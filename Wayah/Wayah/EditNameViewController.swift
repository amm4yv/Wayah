//
//  EditNameViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 9/1/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import CoreData
import UIKit

class EditNameViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - UIView

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        tableView.register(EditNameViewCell.self, forCellReuseIdentifier: "editNameCell")
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .fade)
            break
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        case .update:
            guard let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? EditNameViewCell else { return }
            let entry = fetchedResultsController.object(at: indexPath)
            cell.configureWithEntry(entry)
            break
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entries = fetchedResultsController.fetchedObjects else { return 0 }
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editNameCell", for: indexPath) as! EditNameViewCell
        
        let entry = fetchedResultsController.object(at: indexPath)
        cell.configureWithEntry(entry)
        
        return cell
    }
        
    //        override func tableView(tableView: UITableView,
    //            estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //                return 75;
    //        }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = tableView.dequeueReusableCell(withIdentifier: "editNameCell", for: indexPath) as! EditNameViewCell

        let entry = fetchedResultsController.object(at: indexPath)
        let alert = UIAlertController(title: "Edit Name", message: nil, preferredStyle: UIAlertControllerStyle.alert)

        alert.addTextField { (textField : UITextField) -> Void in
            textField.text = entry.name
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            DataService.delete(entry)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            DataService.updateEntry(entry, name: alert.textFields?.first?.text)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = fetchedResultsController.object(at: indexPath)
            DataService.delete(entry)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Entry> = {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest() as! NSFetchRequest<Entry>
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
}

