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
    
    static var allEntries: [Entry] {
        let fetchRequest = NSFetchRequest<Entry>(entityName: "Entry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
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
    
    static func deleteAllEntries() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

}
