//
//  AddTaskViewController.swift
//  ToDoApplicationScreen
//
//  Created by Evgeniy on 08/04/2019.
//  Copyright © 2019 Evgeniy Kuzmin. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    var name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var taskName: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = taskName.text!
        }
    }
}
