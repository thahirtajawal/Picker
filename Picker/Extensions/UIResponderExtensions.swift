//
//  UIResponderExtensions.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier: String {
        return "\(self)"
    }
}

extension UIView {
    static func nib() -> UINib? {
        return UINib(nibName: identifier, bundle: nil)
    }
}
