//
//  Location.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 8/1/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Location {
    
    let name: String
    let id: Int
    var accuvaxGroups: [AccuvaxGroup] = []
    
    init(locationJSON: JSON) {
        self.name = locationJSON["name"].stringValue
        self.id = locationJSON["id"].intValue
        let accuvaxGroupsJSON = locationJSON["accuvax_groups"].arrayValue
        for accuvaxGroupJSON in accuvaxGroupsJSON {
            self.accuvaxGroups.append(AccuvaxGroup(accuvaxGroupJSON: accuvaxGroupJSON))
        }
    }
}
