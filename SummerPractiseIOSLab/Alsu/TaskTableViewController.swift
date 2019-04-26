//
//  TaskTableViewController.swift
//  SummerPractiseIOSLab
//
//  Created by itisioslab on 22/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

var content: [TaskEntry]?

class TaskTableViewController: UITableViewController {
    @IBOutlet weak var myTableView: UITableView!
    var dateFormatter: DateFormatter = DateFormatter()
    
    func ensureUpToDate() {
        if let data = content {
            let date = Date()
            for task in data {
                if date >= task.date {
                    
                    content!.remove(at: content!.index(where: {
                        (item) -> Bool in
                        item.equals(to: task)
                    })!)
                    
                    
                    let contentData = try! JSONEncoder().encode(content)
                    UserDefaults.standard.set(contentData, forKey: "contentData")
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            content!.remove(at: indexPath.row)
            let contentData = try! JSONEncoder().encode(content)
            UserDefaults.standard.set(contentData, forKey: "contentData")
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.standard.data(forKey: "contentData") {
            content = try! JSONDecoder().decode([TaskEntry].self, from: data)
        }
        else {
            content = [TaskEntry]()
        }
        ensureUpToDate()
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "taskTableCell", for: indexPath) as! TaskTableViewCell
            cell.taskNameLabel.text = content![indexPath.row].taskText
            cell.dateLabel.text = dateFormatter.string(from: content![indexPath.row].date)        
        cell.taskNameLabel?.numberOfLines = 0
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return content!.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
