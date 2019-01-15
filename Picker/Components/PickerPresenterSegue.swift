//
//  PickerPresenterSegue.swift
//  SamplePresentation
//
//  Created by Thahir Maheen on 5/13/18.
//  Copyright © 2018 Thahir. All rights reserved.
//

import UIKit

class PickerPresenterSegue: UIStoryboardSegue {
    
    lazy var pickerPresentationDelegate = PickerPresentationDelegate()

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)

        destination.transitioningDelegate = pickerPresentationDelegate
        destination.modalPresentationStyle = .custom
    }
    
    override func perform() {
        source.present(destination, animated: true, completion: nil)
    }
}
