//
//  Task.swift
//  SummerPractiseIOSLab
//
//  Created by itisioslab on 22/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation

class Task : Codable {
    var taskText: String
    var date: Date
    
    init(text: String, date: Date) {
        taskText = text
        self.date = date
    }
}
