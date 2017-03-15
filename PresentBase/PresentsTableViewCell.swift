//
//  PresentsTableViewCell.swift
//  PresentBase
//
//  Created by Alex Laptop on 3/14/17.
//  Copyright © 2017 Alex Laptop. All rights reserved.
//

import UIKit

class PresentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
