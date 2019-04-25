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
        if (text == ""){
            taskText = "Без названия"}
        else  {taskText = text}
        self.date = date
    }
    
    func equals(to: Task) -> Bool {
        return self.taskText == to.taskText && self.date == to.date
    }
}
