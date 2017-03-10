//
//  Entry.swift
//  Wayah
//
//  Created by Allison Moyer on 3/9/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import CoreData

class Entry: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var info: String?
    @NSManaged var category: Category
    @NSManaged var subcategory: Subcategory
}
