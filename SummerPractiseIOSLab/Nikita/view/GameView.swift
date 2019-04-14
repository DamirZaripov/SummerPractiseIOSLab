//
//  GameView.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class GameView: UIViewController {
    var timeLimit: Float = 10 //seconds
    var initialTime: Float? = nil
    var timer: Timer?
    var currentTask: Task!
    var taskProvider: ITaskProvider!
    var score = 0
    

    @IBOutlet weak var progressBar: CustomProgressView!
    
    
    @IBOutlet weak var taskTextLabel: UITextView!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBAction func exitButton(_ sender: UIButton) {
        endGameImmediately()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskProvider = TaskProviderImpl()
        initialTime = timeLimit
        
        answerButton1.setTitle("", for: .normal)
        answerButton2.setTitle("", for: .normal)
        answerButton3.setTitle("", for: .normal)
        answerButton4.setTitle("", for: .normal)
        taskTextLabel.text = ""
        
        progressBar.progress = 1.0
        startGame()
    }
    
    private func startGame() {
        timer = Timer.scheduledTimer(timeInterval: 0.0333334, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        currentTask = taskProvider.getTask()
        drawUIForCurrentTask()
    }
    
    @IBAction private func handleButtonPressed(_ sender: UIButton) {
        var id: Int {
            switch sender {
            case answerButton1:
                return 0
            case answerButton2:
                return 1
            case answerButton3:
                return 2
            case answerButton4:
                return 3
            default:
                return 4
            }
        }
        let resultOfAction = currentTask.tryAdvance(option: id)
        
        switch resultOfAction {
        case 0:
            var taskText = currentTask.text!
            sender.setTitleColor(UIColor(red: 0.26, green: 0.96, blue: 0.6, alpha: 1), for: .normal)
            taskText = taskText.stringByReplacingFirstOccurrenceOfString(target: String(repeating: "_", count: (sender.titleLabel?.text!.count)!), withString: (sender.titleLabel?.text!)!)
            currentTask.text = taskText
            taskTextLabel.text = taskText
        case 1:
            score += 1
            timeLimit += Float(currentTask.reward!)
            
            let banner = NotificationBanner(title: "Верный ответ!", subtitle: "+\(currentTask.reward!) с.", style: .success)
            banner.bannerHeight = 50.0
            banner.duration = 1.5
            banner.show(queuePosition: .front, bannerPosition: .bottom)
            banner.bannerQueue.removeAll()

            currentTask = taskProvider.getTask()
            drawUIForCurrentTask()
            
        default:
            sender.setTitleColor(UIColor(red: 0.96, green: 0.26, blue: 0.26, alpha: 1), for: .normal)
            endGame()
        }
        
    }
    
    private func drawUIForCurrentTask() {
        answerButton1.setTitleColor(UIColor.white, for: .normal)
        answerButton2.setTitleColor(UIColor.white, for: .normal)
        answerButton3.setTitleColor(UIColor.white, for: .normal)
        answerButton4.setTitleColor(UIColor.white, for: .normal)
        
        answerButton1.setTitle(currentTask?.options![0], for: .normal)
        answerButton2.setTitle(currentTask?.options![1], for: .normal)
        answerButton3.setTitle(currentTask?.options![2], for: .normal)
        answerButton4.setTitle(currentTask?.options![3], for: .normal)
        
        taskTextLabel.text = currentTask.text
    }
    
    private func endGame() {
        let banner = NotificationBanner(title: "Game Over", subtitle: "score: \(score)", style: .danger)
        banner.bannerHeight = 50.0
        banner.duration = 1.5
        banner.show(queuePosition: .front, bannerPosition: .bottom)
        banner.bannerQueue.removeAll()

        
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
        trySaveHighScore()

        timer?.invalidate()
        progressBar.progress = 1
        progressBar.progressTintColor = UIColor(red: 0.96, green: 0.26, blue: 0.26, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    private func trySaveHighScore() {
        let currentHighScore = UserDefaults.standard.integer(forKey: "highscore")
        
        if score > currentHighScore {
            UserDefaults.standard.set(score, forKey: "highscore")
        }
    }
    
    private func endGameImmediately() {
        let banner = NotificationBanner(title: "Game Over", subtitle: "score: \(score)", style: .danger)
        banner.bannerHeight = 50.0
        banner.duration = 1.5
        banner.show(queuePosition: .front, bannerPosition: .bottom)
        banner.bannerQueue.removeAll()
        
        trySaveHighScore()
        
        timer?.invalidate()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func updateTimer() {
        if (timeLimit < 0) {
            endGame()
        }
        else {
            timeLimit -= 0.0333334
            progressBar.progress = timeLimit/initialTime!
        }
    }
    
}
