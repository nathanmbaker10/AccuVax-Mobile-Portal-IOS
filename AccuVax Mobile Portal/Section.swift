//
//  Section.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/8/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation

struct Section {
    var lot: Lot
    var expanded: Bool
    
    init(lot: Lot, expanded: Bool) {
        self.lot = lot
        self.expanded = expanded 
    }
}
