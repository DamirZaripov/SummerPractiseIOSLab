//
//  TasksViewController.swift
//  SummerPractiseIOSLab
//
//  Created by itisioslab on 17/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let dataArray = [["ЗадачаLabel":"SayHello","ВремяLabel":"21.00", "ДатаLabel":"21.04"],
                     ["ЗадачаLabel":"SayHowAreyou","ВремяLabel":"22.00", "ДатаLabel":"22.04"],
                     ["ЗадачаLabel":"SayBuy","ВремяLabel":"19.00", "ДатаLabel":"25.04"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath)  as! NewTableViewCell
        
       let dict = dataArray[indexPath.row]
        
        cell.ЗадачаLabel.text = dict["ЗадачаLabel"]
        cell.ВремяLabel.text = dict["ВремяLabel"]
        cell.ДатаLabel.text = dict["ДатаLabel"]
        
        return cell
    }
}
