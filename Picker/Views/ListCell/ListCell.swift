//
//  ListCell.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

class ListCell<T: Listable>: UITableViewCell {
    typealias ListItem = T
    
    var listable: ListItem? {
        didSet {
            configureView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureView()
    }

    func configureView() {
        guard let listable = listable else { return }
        
        textLabel?.text = listable.listName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        accessoryType = selected ? .checkmark : .none
    }
}
