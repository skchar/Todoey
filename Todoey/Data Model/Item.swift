//
//  Item.swift
//  Todoey
//
//  Created by Char Shu Kai on 14/2/2020.
//  Copyright © 2020 Char Shu Kai. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    
    @objc dynamic var title: String = "" 
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
