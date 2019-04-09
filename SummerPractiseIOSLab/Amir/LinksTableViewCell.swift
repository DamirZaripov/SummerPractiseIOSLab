//
//  LinksTableViewCell.swift
//  tabbedAppPract
//
//  Created by Amir on 30/03/2019.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit

class LinksTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var URLTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with model: SavedLinks) {
        titleTextLabel.text = model.title
        URLTextLabel.text = model.URL
    }
}
