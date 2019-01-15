//
//  PickerController.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

class PickerController: UITableViewController {
    
    @IBAction func barButtonActionDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension PickerController: PickerPresentable {
    var pickerHeight: CGFloat {
        return tableView.bounds.height * 1/3
    }
}
