//
//  Temperature.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/31/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Temperature {
    enum type {
        case cold, frozen
    }
    
    let temp: Double
    let timeStamp: Date
    
    init?(currentJSON: JSON, type: type) {
        switch type {
        case .cold:
            self.temp = currentJSON["current_fridge"].doubleValue
        case .frozen:
            self.temp = currentJSON["current_freezer"].doubleValue
        }
        self.timeStamp = Date()
    }
    init?(historyJSON: JSON, type: type) {
        switch type {
        case .cold:
            self.temp = historyJSON["cold"].doubleValue
        case .frozen:
            self.temp = historyJSON["frozen"].doubleValue
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.timeStamp = formatter.date(from: historyJSON["time"].stringValue)!
    }
    
}
