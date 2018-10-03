//
//  Item.swift
//  Todue
//
//  Created by David Torres on 03.10.18.
//  Copyright © 2018 David Torres. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCateory = LinkingObjects(fromType: Category.self, property: "items")
}
