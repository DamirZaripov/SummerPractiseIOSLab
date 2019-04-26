//
//  ViewController.swift
//  SummerPractiseIOSLab
//
//  Created by itisioslab on 17/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
                return 5;
            }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    
                cell?.textLabel?.text = "BackEnd"
    
                return cell!
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
