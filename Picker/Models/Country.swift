//
//  Country.swift
//  Picker
//
//  Created by Thahir Maheen on 1/14/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import Foundation

struct Country {
    var name = ""
    var code = ""
    
    static func list() -> [Country] {
        return [
            Country(name: "Country1", code: "1"),
            Country(name: "Country2", code: "2"),
            Country(name: "Country3", code: "3"),
            Country(name: "Country4", code: "4"),
            Country(name: "Country5", code: "5"),
            Country(name: "Country6", code: "6"),
            Country(name: "Country7", code: "7"),
            Country(name: "Country8", code: "8")
        ]
    }
}

extension Country: Listable {
    var listName: String {
        return name
    }
}
