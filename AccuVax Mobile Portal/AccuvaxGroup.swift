//
//  AccuvaxGroup.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/1/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AccuvaxGroup {
    let name: String
    let id: Int
    var accuvaxes: [Accuvax] = []
    var sendingFacilities: [String]? = []
    let location: String
    
    init(accuvaxGroupJSON: JSON, location: String) {
        self.location = location
        self.name = accuvaxGroupJSON["name"].stringValue
        self.id = accuvaxGroupJSON["id"].intValue
        let facilitiesArr = accuvaxGroupJSON["sending_facilities"].arrayValue
        for item in facilitiesArr {
            self.sendingFacilities?.append(item["identifier"].stringValue)
        }
        let accuvaxesJSON = accuvaxGroupJSON["accuvaxes"].arrayValue
        for accuvaxJSON in accuvaxesJSON {
            if sendingFacilities?.count != 0 {
                self.accuvaxes.append(Accuvax(accuvaxJSON: accuvaxJSON, sendingFacility: sendingFacilities?[0], location: location))
            } else {
                self.accuvaxes.append(Accuvax(accuvaxJSON: accuvaxJSON, sendingFacility: nil, location: location))
            }
        }
        
    }
}
