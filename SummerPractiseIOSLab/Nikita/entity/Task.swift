//
//  File.swift
//  SummerPractiseIOSLab
//
//  Created by Enoxus on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation

class Task {
    var text: String?
    var answer: [Int]?
    var options: [String]?
    
    private var iterator = 0
    
    func tryAdvance(option: Int) -> Int {
        
        // 0 - вариант правильный, конец не достигнут
        // 1 - вариант правильный, конец достигнут
        // 2 - вариант неправильный
        // 3 - ошибка
        
        guard answer != nil else {
            return 3
        }
        
        if answer![iterator] == option {
            if iterator < answer!.count-1 {
                iterator += 1
                return 0
            }
            else {
                return 1
            }
        }
        else {
            return 2
        }
    }
}
