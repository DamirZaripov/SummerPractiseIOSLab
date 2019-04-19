//
//  SavedLinksController.swift
//  SummerPractiseIOSLab
//
//  Created by Amir on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class SavedLinksController: UITableViewController, UITextFieldDelegate {
    
    var linksArray: [SavedLinks] = [SavedLinks]()
    var filteredLinks = [SavedLinks]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        searchSetup()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredLinks.count
        } else {
            return linksArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var filteredLink: SavedLinks
        
        if isFiltering {
            filteredLink = filteredLinks[indexPath.row]
        } else {
            filteredLink = (linksArray[indexPath.row])
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LinksTableViewCell
        cell.configureCell(with: filteredLink)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
            self.linksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveData()
        }
        let edit = UITableViewRowAction(style: .normal, title: "Изменить") { (action, indexPath) in
            self.editingAlert(indexPath)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.7960784314, alpha: 1)
        
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        linksArray.swapAt(fromIndexPath.row, to.row)
        tableView.moveRow(at: fromIndexPath, to: to)
        saveData()
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Add
    func isURL(value: String?) -> Bool {
        let regex = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return ((value?.range(of: regex, options: .regularExpression)) != nil)
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        if !isURL(value: UIPasteboard.general.string) {
            warningAlert()
        } else {
            addingNewLinkAlert()
        }
    }
    
    // MARK: - Alerts
    fileprivate func addingNewLinkAlert() {
        let pasteboard = UIPasteboard.general
        let messageText = pasteboard.string
        
        let alert = UIAlertController(title: "Добавить новую ссылку", message: messageText, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Название"
            textField.delegate = self
            textField.addTarget(alert, action: #selector(alert.textDidChangeInAlert), for: .editingChanged)
        }
        
        let addBtn = UIAlertAction(title: "Добавить", style: .default) { (add) in
            let newTitle = alert.textFields?.first?.text
            self.linksArray.append(SavedLinks(title: newTitle!, URL: alert.message!))
            self.tableView.insertRows(at: [IndexPath(row: self.linksArray.count - 1, section: 0)], with: .fade)
            self.tableView.reloadData()
            self.saveData()
        }
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(addBtn)
        addBtn.isEnabled = false
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate func warningAlert() {
        let alertWhenPasteboardIsNil = UIAlertController(title: "Буфер обмена не содержит URL адрес!", message: "Пожалуйста, убедитесь, что вы правильно скопировали URL адрес сайта", preferredStyle: .alert)
        let dismissBtn = UIAlertAction(title: "Я все понял", style: .destructive, handler: nil)
        alertWhenPasteboardIsNil.addAction(dismissBtn)
        self.present(alertWhenPasteboardIsNil, animated: true, completion: nil)
    }
    
    fileprivate func editingAlert(_ indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Редактирование заголовка для ссылки: ", message: self.linksArray[indexPath.row].URL, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Новое название"
            textField.text = self.linksArray[indexPath.row].title
            textField.addTarget(alert, action: #selector(alert.textDidChangeInAlert), for: .editingChanged)
        }
        
        let changeBtn = UIAlertAction(title: "Изменить", style: .default) { (change) in
            let newTitle = alert.textFields?.first?.text
            self.linksArray[indexPath.row].title = newTitle!
            self.tableView.reloadData()
            self.saveData()
        }
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(changeBtn)

        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Search by title
    
    fileprivate func searchSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по названию"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = SavedLinks(title: linksArray[indexPath.row].title, URL: linksArray[indexPath.row].URL)
        performSegue(withIdentifier: "segueId", sender: model)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueId", let model = sender as? SavedLinks {
            let destination = segue.destination as! WebViewController
            destination.model = model
        }
    }
    
    //MARK: - UserDefaults
    
    var defaults = UserDefaults.standard
    func saveData() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: linksArray, requiringSecureCoding: false) {
            defaults.set(savedData, forKey: "links")
        }
    }
    
    func loadData() {
        if let savedLinks = defaults.object(forKey: "links") as? Data {
            if let decodedLinks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedLinks) as? [SavedLinks] {
                linksArray = decodedLinks!
            }
        }
    }
}
