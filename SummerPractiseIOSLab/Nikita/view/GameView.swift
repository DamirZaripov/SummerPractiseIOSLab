//
//  GameView.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class GameView: UIViewController {
    var timeLimit: Float = 10 //seconds
    var initialTime: Float? = nil
    var timer: Timer?
    var currentTask: Task?
    var taskProvider: ITaskProvider?
    var score = 0
    

    @IBOutlet weak var progressBar: CustomProgressView!
    
    
    @IBOutlet weak var taskTextLabel: UITextView!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func firstButtonPress(_ sender: UIButton) {
        handleButtonPressed(button: sender)
    }
    
    @IBAction func secondButtonPress(_ sender: UIButton) {
        handleButtonPressed(button: sender)
    }
    
    @IBAction func thirdButtonPress(_ sender: UIButton) {
        handleButtonPressed(button: sender)

    }
    
    @IBAction func fourthButtonPress(_ sender: UIButton) {
        handleButtonPressed(button: sender)
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
        currentTask = taskProvider!.getTask()
        drawUIForCurrentTask()
    }
    
    private func handleButtonPressed(button: UIButton) {
        var id: Int {
            switch button {
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
        let resultOfAction = currentTask!.tryAdvance(option: id)
        
        switch resultOfAction {
        case 0:
            button.setTitleColor(UIColor.green, for: .normal)
        case 1:
            score += 1
            timeLimit += 5.0
            
            currentTask = taskProvider?.getTask()
            drawUIForCurrentTask()
            
        default:
            button.setTitleColor(UIColor.red, for: .normal)
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
        
        taskTextLabel.text = currentTask?.text
    }
    
    private func endGame() {
        let currentHighScore = UserDefaults.standard.object(forKey: "highscore") as? Int ?? 0
        
        if score > currentHighScore {
            UserDefaults.standard.set(score, forKey: "highscore")
        }
        timer?.invalidate()
        progressBar.progress = 1
        progressBar.progressTintColor = UIColor.red
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: true)
        }
        
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
