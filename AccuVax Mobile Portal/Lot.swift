//
//  JSON.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/25/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Lot {
    let name: String
    let brand_name: String
    let expirationDate: String
    var count: Int
    var dosesRemaining: Int
    let owner: String
    let program: String
    let lotCode: String
    let productNDC: String
    let packageNDC: String
    let accuvaxName: String
    var cvxCode: String? = nil

    init(inventoryJSON: JSON) {
        let inventory = inventoryJSON.dictionaryValue
        self.name = inventory["vaccine_name"]!.stringValue
        self.brand_name = inventory["brand_name"]!.stringValue
        self.owner = inventory["owner"]!.stringValue
        self.count = inventory["count"]!.intValue
        self.dosesRemaining = inventory["doses_remaining"]!.intValue
        self.expirationDate = inventory["expiration"]!.stringValue
        self.accuvaxName = inventory["accuvax_name"]!.stringValue
        self.lotCode = inventory["lot"]!.stringValue
        self.productNDC = inventory["product_ndc"]!.stringValue
        self.packageNDC = inventory["package_ndc"]!.stringValue
        self.program = inventory["program"]!.stringValue
        if let cvx = inventory["cvx_code"]?.stringValue {
            self.cvxCode = cvx
        }
    }
}
