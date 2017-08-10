//
//  ExpandedLotTableViewCell.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/9/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class ExpandedLotTableViewCell: UITableViewCell {
    @IBOutlet weak var vialCountLabel: UILabel!
    @IBOutlet weak var dosesRemainingLabel: UILabel!
    @IBOutlet weak var ownerLable: UILabel!
    @IBOutlet weak var productNDCLabel: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var packageNDCLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
