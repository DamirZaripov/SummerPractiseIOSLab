//
//  ToDoListTableViewController.swift
//  ToDoApplicationScreen
//
//  Created by Evgeniy on 08/04/2019.
//  Copyright © 2019 Evgeniy Kuzmin. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    var sections = UserDefaults.standard.stringArray(forKey: "ToDoSectionsArray") ?? ["To Do List", "Completed"]
    var tasksToDo : [String]!
    var tasksCompleted : [String]!
    var newTask : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksToDo = UserDefaults.standard.stringArray(forKey: "ArrayToDoTasks") ?? []
        tasksCompleted = UserDefaults.standard.stringArray(forKey: "ArrayCompletedTasks") ?? []
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tasksToDo.count
        case 1:
            return tasksCompleted.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        var attributeString : NSMutableAttributedString!
        if indexPath.section == 0{
            attributeString =  NSMutableAttributedString(string: self.tasksToDo[indexPath.row])
        } else if indexPath.section == 1{
            attributeString =  NSMutableAttributedString(string: self.tasksCompleted[indexPath.row])
        }
        if indexPath.section == 1 {
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        cell.textLabel?.attributedText = attributeString
        return cell
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue){
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let taskAddTaskVC = segue.source as! AddTaskViewController
                self.newTask = taskAddTaskVC.name
                if (self.newTask != ""){
                self.tasksToDo.append(self.newTask)
                    self.saveData(toDoArray: self.tasksToDo, completedArray: self.tasksCompleted)
                    tableView.reloadData()
                }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0{
                self.tasksToDo.remove(at: indexPath.row)
            } else if indexPath.section == 1{
                self.tasksCompleted.remove(at: indexPath.row)
            }
            self.saveData(toDoArray: self.tasksToDo, completedArray: self.tasksCompleted)
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
                var neededString = self.tasksToDo.remove(at: indexPath.row)
                self.tasksCompleted.append(neededString)
                self.saveData(toDoArray: self.tasksToDo, completedArray: self.tasksCompleted)
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
        var array : [String]!
        if section == 0 {
            array = tasksToDo
        } else if section == 1{
            array = tasksCompleted
        }
        if array.count == 0 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
            footerView.backgroundColor = UIColor.white
            let label = UILabel()
            label.text = "empty"
            label.textColor = UIColor.lightGray
            label.frame = CGRect(x: 165, y: 0, width: footerView.frame.size.width, height: footerView.frame.size.height)
            footerView.addSubview(label)
            return footerView
        }
        else {
            let footerView = UIView()
            return footerView
        }
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var array : [String]!
        if section == 0 {
            array = tasksToDo
        } else if section == 1{
            array = tasksCompleted
        }
        if array != [] {
            return 0
        }
        return 40
    }
    
    func saveData(toDoArray : [String], completedArray : [String]){
        
        UserDefaults.standard.set(toDoArray, forKey: "ArrayToDoTasks")
        UserDefaults.standard.set(completedArray, forKey: "ArrayCompletedTasks")
        UserDefaults.standard.synchronize()
    }
}
