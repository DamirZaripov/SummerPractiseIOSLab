//
//  NotificationViewController.swift
//  SummerPractiseIOSLab
//
//  Created by itisioslab on 22/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textEdit: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let text = textEdit.text {
            let date = datePicker.date
            content?.append(TaskEntry(text: text, date: date))
            let contentData = try! JSONEncoder().encode(content)
            UserDefaults.standard.set(contentData, forKey: "contentData")
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBOutlet weak var Save: UIButton!
    

    
    


}
