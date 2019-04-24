//
//  Extensions.swift
//  SummerPractiseIOSLab
//
//  Created by Amir on 18/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
    func isValidTitle(_ title: String) -> Bool {
        let letters = CharacterSet.letters
        let nums = CharacterSet.decimalDigits
        return (title.rangeOfCharacter(from: letters) != nil)
                || (title.rangeOfCharacter(from: nums) != nil)
    }
    
    @objc func textDidChangeInAlert() {
        if let text = textFields?.first?.text, let action = actions.last {
            action.isEnabled = isValidTitle(text)
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
