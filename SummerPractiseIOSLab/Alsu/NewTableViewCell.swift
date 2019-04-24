//
//  NewTableViewCell.swift
//  SummerPractiseIOSLab
//
//  Created by itisioslab on 18/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var ЗадачаLabel: UILabel!
    @IBOutlet weak var ВремяLabel: UILabel!
    @IBOutlet weak var ДатаLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
