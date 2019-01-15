//
//  CountryListViewController.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

class CountryListViewController: ListViewController<Country> {
    
    enum Mode {
        case code
        case name
    }
    
    var mode = Mode.code {
        didSet {
            registerCells()
        }
    }
    
    override func registerCells() {
        mode == .code ? register(nib: CountryCell.nib()) : register(cellType: ListCell<Country>.self)
    }
}

extension CountryListViewController {
    static func show(from presentingController: UIViewController, with list: [Country], mode: CountryListViewController.Mode = .name, completion: @escaping CountryListViewController.ListSelectionHandler) {
        
        // create list view controller
        let listViewController = CountryListViewController(with: list)
        listViewController.mode = mode
        listViewController.listSelectionHandler = completion
        
        // present the list view controller inside a navigation controller
        let navigationController = UINavigationController(rootViewController: listViewController)
        presentingController.present(navigationController, animated: true)
    }
}
