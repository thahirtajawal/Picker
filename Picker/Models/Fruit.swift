//
//  Fruit.swift
//  Picker
//
//  Created by Thahir Maheen on 1/15/19.
//  Copyright © 2019 Thahir Maheen. All rights reserved.
//

import Foundation

struct Fruit {
    var name = ""
    
    static func list() -> [Fruit] {
        return [
            Fruit(name: "Fruit1"),
            Fruit(name: "Fruit2"),
            Fruit(name: "Fruit3"),
            Fruit(name: "Fruit4"),
            Fruit(name: "Fruit5"),
            Fruit(name: "Fruit6"),
            Fruit(name: "Fruit7"),
            Fruit(name: "Fruit8")
        ]
    }
}

extension Fruit: Listable {
    var listName: String {
        return name
    }
}
