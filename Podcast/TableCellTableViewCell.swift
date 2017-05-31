//
//  TableCellTableViewCell.swift
//  Podcast
//
//  Created by Zachary Auten on 3/1/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var logo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

    /**
    @IBAction func play(sender: UIButton) {
        
    }
    **/
}
