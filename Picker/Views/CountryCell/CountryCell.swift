//
//  CountryCell.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

class CountryCell: ListCell<Country> {
    
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelName: UILabel!

    override func configureView() {
        guard let country = listable else { return }
        
        labelCode?.text = country.code
        labelName?.text = country.name
    }    
}
