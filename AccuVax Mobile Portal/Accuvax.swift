//
//  File.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/1/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Accuvax {
    static var current: Accuvax?
    static var email: String?
    static var password: String?
    let location: String
    let name: String
    let id: Int
    let serialNumber: String
    var sendingFacility: String? = nil
    
    init(accuvaxJSON: JSON, sendingFacility: String?, location: String) {
        if let sendingFacility = sendingFacility {
            self.sendingFacility = sendingFacility
        }
        self.name = accuvaxJSON["name"].stringValue
        self.id = accuvaxJSON["id"].intValue
        self.serialNumber = accuvaxJSON["serialnumber"].stringValue
        self.location = location
    }
}
