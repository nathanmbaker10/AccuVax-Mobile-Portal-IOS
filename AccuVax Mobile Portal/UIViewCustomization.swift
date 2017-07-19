//
//  UI View added Corner Radius.swift
//  AccuVax Mobile Portal
//
//  Created by Nathan Baker on 7/19/17.
//  Copyright © 2017 Nathan Baker. All rights reserved.
//

import UIKit
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
