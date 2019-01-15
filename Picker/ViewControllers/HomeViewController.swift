//
//  HomeViewController.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var labelSelection: UILabel!
    
    @IBAction func buttonActionFruits(_ sender: UIButton) {
        ListViewController<Fruit>.show(from: self, with: Fruit.list()) { selectedFruit in
            self.labelSelection.text = selectedFruit.listName
        }
    }
    
    @IBAction func buttonActionCountries(_ sender: UIButton) {
        CountryListViewController.show(from: self, with: Country.list()) { selectedCountry in
            self.labelSelection.text = selectedCountry.listName
        }
    }
    
    @IBAction func buttonActionCountriesWithCode(_ sender: UIButton) {
        CountryListViewController.show(from: self, with: Country.list(), mode: .code) { selectedCountry in
            self.labelSelection.text = selectedCountry.listName
        }
    }
}
