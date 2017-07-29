//
//  Vaccine.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/25/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Vaccine {
    let name: String
    let brandName: String
    var totalCount: Int
    var totalDosesRemaining: Int
    var lots: [Lot]? = []
    
    init?(root: JSON, name: String) {
        self.name = name
        let inventories = root["inventories"].arrayValue
        for dict in inventories {
            if dict["vaccine_name"].stringValue == self.name {
                lots?.append(Lot(inventoryJSON: dict))
            }
        }
        if lots?.count != 0 {
            self.brandName = lots![0].brand_name
            totalCount = 0
            totalDosesRemaining = 0
            for lot in lots! {
                totalCount += lot.count
                totalDosesRemaining += lot.dosesRemaining
            }
        } else {
            return nil
        }
    }
    init(brandName: VaccineBrandName, initialLot: Lot) {
        self.brandName = brandName.rawValue
        self.name = initialLot.name
        self.totalCount = initialLot.count
        self.totalDosesRemaining = initialLot.dosesRemaining
        self.lots?.append(initialLot)
    }
}
