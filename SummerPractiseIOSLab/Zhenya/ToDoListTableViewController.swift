//
//  ToDoListTableViewController.swift
//  ToDoApplicationScreen
//
//  Created by Evgeniy on 08/04/2019.
//  Copyright © 2019 Evgeniy Kuzmin. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    var sections = ["To Do List", "Completed"]
    var tasks = [["Some task"],["Some ended task"]]
    var newTask : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = tasks[indexPath.section][indexPath.row]
        
        return cell
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let taskAddTaskVC = segue.source as! AddTaskViewController
        newTask = taskAddTaskVC.name
        if (newTask != ""){
        tasks[0].append(newTask)
        }
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
            let message = "Mark this task as \"Completed\"?"
            let title = "Confirmation"
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                var neededString = self.tasks[0].remove(at: indexPath.row)
                self.tasks[1].append(neededString)
                tableView.reloadData()
        
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: false)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.backgroundColor = UIColor.black
        return footerView
    }
}
