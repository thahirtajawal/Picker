//
//  ListViewController.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

class ListViewController<T: Listable>: UITableViewController {
    typealias ListElement = T
    typealias ListSelectionHandler = (_ selectedItem: ListElement) -> ()
    
    // list to be loaded by tableview
    var list = [ListElement]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    // selected list item
    var selectedListItem: ListElement? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    // handler to select a list item
    var listSelectionHandler: ListSelectionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cells
        registerCells()
    }
    
    convenience init(with list: [ListElement]) {
        self.init(style: .plain)
        self.list = list
    }
    
    func registerCells() {
        register(cellType: ListCell<ListElement>.self)
    }
    
    func register(cellType: UITableViewCell.Type) {
        tableView.register(cellType, forCellReuseIdentifier: ListViewController<ListElement>.identifier)
    }
    
    func register(nib: UINib?) {
        tableView.register(nib, forCellReuseIdentifier: ListViewController<ListElement>.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: ListViewController<ListElement>.identifier) as? ListCell<ListElement> else { return UITableViewCell() }
        listCell.listable = list[indexPath.row]
        return listCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.listSelectionHandler?(self.list[indexPath.row])
        }
    }
}

extension ListViewController {
    static func show<T: Listable>(from presentingController: UIViewController, with list: [T], completion: @escaping ListViewController<T>.ListSelectionHandler) {
        
        // create list view controller
        let listViewController = ListViewController<T>(with: list)
        listViewController.listSelectionHandler = completion
        
        // present the list view controller inside a navigation controller
        let navigationController = UINavigationController(rootViewController: listViewController)
        presentingController.present(navigationController, animated: true)
    }
}
