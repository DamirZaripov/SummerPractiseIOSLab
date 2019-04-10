//
//  TaskProviderImpl.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation

class TaskProviderImpl : ITaskProvider {
    var storage = [Task]()
    
    func getTask() -> Task {
        if storage.count == 0 {
            fill()
        }
        
        let task = storage.randomElement()!
        storage.remove(at: storage.firstIndex(where: {$0 === task})!)
        return task
    }
    
    func fill() {
        var task1 = Task()
        task1.text = "   ____ a(a: Int, b:Int) -> ___ {           return a+b   }  "
        
        task1.options = ["func", "class", "Int", "override"]
        task1.answer = [0,2]
        task1.reward = 2
        storage.append(task1)
    }
    
    init() {
        fill()
    }
    
}
