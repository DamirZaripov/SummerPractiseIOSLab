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
    var searchBarIsEmpty: Bool{
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
            
            let alert = UIAlertController(title: "Редактирование ссылки: ", message: self.linksArray[indexPath.row].URL, preferredStyle: .alert)
            
            let changeBtn = UIAlertAction(title: "Изменить", style: .default) { (add) in
                let newTitle = alert.textFields?.first?.text
                self.linksArray[indexPath.row].title = newTitle!
                self.tableView.reloadData()
                self.saveData()
            }
            let cancelBtn = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
            alert.addAction(changeBtn)
            alert.addAction(cancelBtn)
            alert.addTextField { (textField) in
                textField.placeholder = "Введите название: "
            }
            self.present(alert, animated: true, completion: nil)
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
    
    // MARK: - Add & search
    
    @IBAction func addBtnAction(_ sender: Any) {
        if UIPasteboard.general.string == nil {
            let alertWhenPasteboardIsNil = UIAlertController(title: "Буфер обмена пуст!", message: "Пожалуйста, скопируйте ссылку, которую хотите сохранить", preferredStyle: .alert)
            let dismissBtn = UIAlertAction(title: "Я все понял", style: .destructive, handler: nil)
            alertWhenPasteboardIsNil.addAction(dismissBtn)
            self.present(alertWhenPasteboardIsNil, animated: true, completion: nil)
        } else {
            alertConfigure()
        }
    }
    
    fileprivate func alertConfigure() {
        
        let pasteboard = UIPasteboard.general
        let messageText = pasteboard.string
        
        
        let alert = UIAlertController(title: "Добавить новую ссылку", message: messageText, preferredStyle: .alert)
        
        let addBtn = UIAlertAction(title: "Добавить", style: .default) { (add) in
            let newTitle = alert.textFields?.first?.text
            self.linksArray.append(SavedLinks(title: newTitle!, URL: alert.message!))
            self.tableView.insertRows(at: [IndexPath(row: self.linksArray.count - 1, section: 0)], with: .fade)
            self.tableView.reloadData()
            self.saveData()
        }
        let cancelBtn = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alert.addTextField { (textField) in
            textField.placeholder = "Введите название: "
        }
        addBtn.isEnabled = true
        alert.addAction(addBtn)
        alert.addAction(cancelBtn)
        
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
    
    // MARK: - UserDefaults
    
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

extension SavedLinksController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchContent(searchController.searchBar.text!)
    }
    private func searchContent(_ searchText: String) {
        filteredLinks = linksArray.filter({ (links: SavedLinks) -> Bool in
            return links.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
