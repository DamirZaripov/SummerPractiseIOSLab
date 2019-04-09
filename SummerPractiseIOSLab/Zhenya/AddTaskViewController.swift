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

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var taskName: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = taskName.text!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
