//
//  MainView.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        highscoreLabel.text = "Highscore: " + String(UserDefaults.standard.integer(forKey: "highscore"))
        

    }
}
