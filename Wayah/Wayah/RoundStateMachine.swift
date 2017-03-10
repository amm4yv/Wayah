//
//  RoundStateMachine.swift
//  Wayah
//
//  Created by Allison Moyer on 3/9/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class RoundStateMachine: NSObject, NSFetchedResultsControllerDelegate {
    
    fileprivate(set) var bowl1: [Entry] = []
    fileprivate(set) var bowl2: [Entry] = []
    
    fileprivate(set) var entryIndex: Int = 0
    fileprivate(set) var currentTeam: Team
    fileprivate(set) var numCorrect: Int = 0

    fileprivate(set) var roundIsOver: Bool = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    
    var currentEntry: Entry {
        return bowl1[entryIndex]
    }
    
    override init() {
        self.currentTeam = gameStateMachine.getFirstTeam()
        super.init()
    }
    
    func startNewRound() {
        guard let objects = fetchedResultsController.fetchedObjects else { return }
        bowl1 = objects
        bowl2 = []
        entryIndex = Int(arc4random_uniform(UInt32(bowl1.count)))
    }
    
    func entryGuessedCorrectly() {
        numCorrect += 1
        currentTeam.selectedCorrectItem()
        bowl2.append(bowl1.remove(at: entryIndex))
        
        if bowl1.isEmpty {
            endRound()
            
        } else {
            entryIndex = Int(arc4random_uniform(UInt32(bowl1.count)))
        }
    }
    
    func entrySkipped() {
        entryIndex = Int(arc4random_uniform(UInt32(bowl1.count)))
    }
    
    func endTurn() {
        numCorrect = 0
        currentTeam = gameStateMachine.getNextTeam(currentTeam: currentTeam)
    }
    
    func endRound() {
        bowl1 = []
        bowl2 = []
        entryIndex = 0
        numCorrect = 0
        roundIsOver = true
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
