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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //  How many cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].count
    }

    // Cell constructing
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
            
            
            
//            var neededString = tasks[0].remove(at: indexPath.row)
//            tasks[1].append(neededString)
//            tableView.reloadData()
        
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
//    func createAlert (title:String, message:String) -> Bool
//    {
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//
//        //CREATING ON BUTTON
//        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
//            alert.dismiss(animated: true, completion: nil)
//            var isYes = true
//            return isYes
//        }))
//
//        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
//            alert.dismiss(animated: true, completion: nil)
//            var isYes = false
//            return isYes
//        }))
//
//        self.present(alert, animated: true, completion: nil)
//
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none
//        {
////            var neededStrig = tasks.remove(at: indexPath.row)
////            tasks.insert(neededStrig, at: tasks.count)
//
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
//            tableView.reloadData()
//        } //else
////        {
////            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
////        }
//    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//            var neededStrig = tasks.remove(at: fromIndexPath.row)
//            tasks.insert(neededStrig, at: tasks.count)
//    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
