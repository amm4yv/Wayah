//
//  DataService.swift
//  Wayah
//
//  Created by Allison Moyer on 3/10/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class DataService {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func addEntryWithName(_ name: String?) {
        guard let name = name, !name.isEmpty else { return }
        guard let newEntry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: context) as? Entry else { return }
        
        newEntry.name = name
        appDelegate.saveContext()
    }
    
    static func updateEntry(_ entry: Entry?, name: String?) {
        guard let entry = entry, let name = name else { return }
        entry.name = name
        appDelegate.saveContext()
    }
    
    static func delete(_ object: NSManagedObject) {
        context.delete(object)
        appDelegate.saveContext()
    }
    
    static func deleteAllEntities() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch _ as NSError {
            // TODO: handle the error
        }
    }
    
}
