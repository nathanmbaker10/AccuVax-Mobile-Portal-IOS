//
//  KioskTableViewCell.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/18/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

class KioskTableViewCell: UITableViewCell {

    @IBOutlet weak var kioskLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
