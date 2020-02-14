//
//  Category.swift
//  Todoey
//
//  Created by Char Shu Kai on 14/2/2020.
//  Copyright © 2020 Char Shu Kai. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
