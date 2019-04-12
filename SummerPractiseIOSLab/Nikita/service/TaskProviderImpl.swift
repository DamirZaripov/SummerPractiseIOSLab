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
        
        let removingIndex = Int.random(in: 0...storage.count-1)
        let task = storage[removingIndex]
        storage.remove(at: removingIndex)
        return task
    }
    
    func fill() {
        let task1 = Task()
        task1.text = "   ____ a(a: Int, b:Int) -> ____ {           return a+b   }  "
        
        task1.options = ["func", "class", "Int", "override"]
        task1.answer = [0,2]
        task1.reward = 3
        storage.append(task1)

        let task2 = Task()
        task2.text = "____ myDict = [\n    \"firstKey\":\"firstValue\"\n]\nfor (key, ____) in myDict {\n    print(\"\\(key) = \\(value)\")\n}"
        task2.options = ["key", "value", "var", "func"]
        task2.answer = [2, 1]
        task2.reward = 3
        storage.append(task2)
        
        let task3 = Task()
        task3.text = "let myConstant = 120.25\n\nКакой тип у константы myConstant?"
        task3.options = ["Int", "Decimal", "Float", "Double"]
        task3.answer = [3]
        task3.reward = 1
        storage.append(task3)
        
        
        let task4 = Task()
        task4.text = "var numbers = [1,2,3]\nnumbers += [4]\n\nСколько чисел находится в массиве numbers?"
        task4.options = ["0", "4", "3", "1"]
        task4.answer = [1]
        task4.reward = 1
        storage.append(task4)
        
        let task5 = Task()
        task5.text = "let names = [String]()\nnames.append(\"Amy\")\nnames.append(\"Clara\")\n\n Сколько строк содержится в массиве names?"
        
        task5.options = ["0","1","2","3"]
        task5.answer = [0]
        task5.reward = 1
        storage.append(task5)
        
        let task6 = Task()
        task6.text = "let i = \"5\"\nlet j = i + i\n\nЧто содержит константа j?"
        task6.options = ["10", "\"5\"", "\"55\"", "[\"5\", \"5\"]"]
        task6.answer = [2]
        task6.reward = 1
        storage.append(task6)
        
        let task7 = Task()
        task7.text = "var i = 2\nrepeat {\n    i *= i * 2\n} while i < 100\nprint(i)\nЧто выведет этот код?"
        task7.options = ["2", "64", "128", "256"]
        task7.answer = [2]
        task7.reward = 1
        storage.append(task7)
        
        let task8 = Task()
        task8.text = "func printAll(items: String...) {\n    ____ item in ____ {\n        print(____)\n    }\n}"
        task8.options = ["print","for","item", "items"]
        task8.answer = [1,3,2]
        task8.reward = 5
        storage.append(task8)
        
    }
    
    init() {
        fill()
    }
    
}
