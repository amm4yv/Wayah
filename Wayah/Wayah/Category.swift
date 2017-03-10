//
//  Category.swift
//  Wayah
//
//  Created by Allison Moyer on 3/9/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import CoreData

class Category: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var subcategories: [Subcategory]
    @NSManaged var entries: [Entry]
}
