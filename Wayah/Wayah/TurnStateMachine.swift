//
//  TurnStateMachine.swift
//  Wayah
//
//  Created by Allison Moyer on 3/11/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import Foundation

class TurnStateMachine: NSObject {
    
    fileprivate(set) var entries: [Entry] = []

    fileprivate(set) var correctEntries: [Entry] = []
    fileprivate(set) var skippedEntries: [Entry] = []
    
    fileprivate(set) var currentTeam: Team

    var turnIsOver = false
    
    var currentEntry: Entry
    
    var numCorrect: Int {
        return correctEntries.count
    }
    
    var numSkipped: Int {
        return skippedEntries.count
    }
    
    init(team: Team, entries: [Entry]) {
        self.currentTeam = team
        self.entries = entries
        self.currentEntry = entries.first!
        
        super.init()
    }
    
    func entryGuessedCorrectly() {
        correctEntries.append(currentEntry)
        
        if let entry = entries.first(where: { (entry: Entry) -> Bool in
            return !correctEntries.contains(entry)
        }) {
            currentEntry = entry
        } else {
            turnIsOver = true
        }
    }
    
    func entrySkipped() {
        skippedEntries.append(currentEntry)
        currentEntry = entries.first { (entry: Entry) -> Bool in
            return !correctEntries.contains(entry)
        }!
    }
    
    func toggleEntryState(_ entry: Entry) {
        if let index = correctEntries.index(of: entry) {
            correctEntries.remove(at: index)
            skippedEntries.append(entry)
            
        } else if let index = skippedEntries.index(of: entry) {
            skippedEntries.remove(at: index)
            correctEntries.append(entry)
        }
    }

}
