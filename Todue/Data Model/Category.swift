//
//  Category.swift
//  Todue
//
//  Created by David Torres on 03.10.18.
//  Copyright © 2018 David Torres. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
