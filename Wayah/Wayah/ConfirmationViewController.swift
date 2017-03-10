//
//  ConfirmationViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/4/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import CoreData
import UIKit

class ConfirmationViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var namesInBowl: UILabel!
    
    @IBOutlet weak var timeLimit: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!
    
    var allowSkipping = true
    
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    
    @IBAction func timeStepperValueChanged(_ sender: UIStepper) {
        timeLimit.text = Int(sender.value).description
    }
    
    @IBAction func skippingValueChanged(_ sender: UISwitch) {
        allowSkipping = !allowSkipping
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLimit.text = String(gameStateMachine.settings.timeLimit)
        namesInBowl.text = String(fetchedResultsController.fetchedObjects?.count ?? 0)
        
        gameStateMachine.scores.create(numberOfTeams: gameStateMachine.settings.numTeams)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gameStateMachine.updateSettings(numTeams: "2", timeLimit: String(timeStepper.value), allowSkipping: allowSkipping)

    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Entry> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest() as! NSFetchRequest<Entry>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
}
