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
        task1.text = "     ____ a(a: Int, b:Int) -> ___ {           return a+b  }  "
        
        task1.options = ["func", "class", "Int", "override"]
        task1.answer = [0,2]
        task1.reward = 3
        storage.append(task1)
        
        let task2 = Task()
        task2.text = "    ___ myDict = [\n        \"firstKey\":\"firstValue\"\n    ]\n    for (key, _____) in myDict {\n        print(\"\\(key) = \\(value)\")\n    }"
        task2.options = ["key", "value", "var", "func"]
        task2.answer = [2, 1]
        task2.reward = 3
        storage.append(task2)
        
        let task3 = Task()
        task3.text = "     let myConstant = 120.25\n\n     Какой тип у константы\n     myConstant?"
        task3.options = ["Int", "Decimal", "Float", "Double"]
        task3.answer = [3]
        task3.reward = 1
        storage.append(task3)
        
        
        let task4 = Task()
        task4.text = "   var numbers = [1,2,3]\n   numbers += [4]\n\n   Сколько чисел находится в \n   массиве numbers?"
        task4.options = ["0", "4", "3", "1"]
        task4.answer = [1]
        task4.reward = 1
        storage.append(task4)
        
        let task5 = Task()
        task5.text = "  let names = [String]()\n  names.append(\"Amy\")\n  names.append(\"Clara\")\n\n  Сколько строк содержится в\n  массиве names?"
        
        task5.options = ["0","1","2","3"]
        task5.answer = [0]
        task5.reward = 1
        storage.append(task5)
        
        let task6 = Task()
        task6.text = "  let i = \"5\"\n  let j = i + i\n\n  Что содержит константа j?"
        task6.options = ["10", "\"5\"", "\"55\"", "[\"5\", \"5\"]"]
        task6.answer = [2]
        task6.reward = 1
        storage.append(task6)
        
        let task7 = Task()
        task7.text = "     var i = 2\n     repeat {\n         i *= i * 2\n     } while i < 100\n     print(i)\n     Что выведет этот код?"
        task7.options = ["2", "64", "128", "256"]
        task7.answer = [2]
        task7.reward = 1
        storage.append(task7)
        
        let task8 = Task()
        task8.text = "  func printAll(items: String...) {\n      ___ item in _____ {\n          print(____)\n      }\n  }"
        task8.options = ["print","for","item", "items"]
        task8.answer = [1,3,2]
        task8.reward = 5
        storage.append(task8)
        
        let task9 = Task()
        task9.text = "    _________ String {\n        ____ shout() {\n            print(____ + \"!\")\n        }\n    }\n     \"String\".shout() // \"String!\""
        task9.options = ["extension", "class", "self", "func"]
        task9.answer = [0,3,2]
        task9.reward = 3
        storage.append(task9)
        
        let task10 = Task()
        task10.text = "     Сколько реализаций\n     массивов существует в\n     стандартной\n     библиотеке Swift?"
        task10.options = ["1", "3", "5", "8"]
        task10.answer = [1]
        task10.reward = 1
        storage.append(task10)
    }
    
    init() {
        fill()
    }
    
}
