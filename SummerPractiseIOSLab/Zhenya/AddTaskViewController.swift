//
//  AddTaskViewController.swift
//  ToDoApplicationScreen
//
//  Created by Evgeniy on 08/04/2019.
//  Copyright © 2019 Evgeniy Kuzmin. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    var name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskName.delegate = self
    }
    
    
    @IBOutlet weak var taskName: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = taskName.text!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ taskName: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
