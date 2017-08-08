//
//  LotExpandableHeader.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/8/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit

protocol LotExpandableHeaderDelegate {
    func toggleSection(header: LotExpandableHeader, section: Int)
}

class LotExpandableHeader: UITableViewHeaderFooterView {
    var delegate: LotExpandableHeaderDelegate?
    var section: Int!
    
    
    @IBOutlet weak var lotCodeLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
    }
    
    func selectHeaderView(gesture: UITapGestureRecognizer) {
        let cell = gesture.view as! LotExpandableHeader
        delegate?.toggleSection(header: self, section: cell.section)
        
    }
    
    func customInit(lot: Lot, delegate: LotExpandableHeaderDelegate, section: Int) {
        self.section = section
        self.lotCodeLabel.text = lot.lotCode
        self.expirationDateLabel.text = lot.expirationDate
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
