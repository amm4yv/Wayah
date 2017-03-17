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


extension Notification.Name {
    static let entriesUpdated = Notification.Name("entries-updated")
}


class RoundStateMachine: NSObject, NSFetchedResultsControllerDelegate {
    
    fileprivate(set) var currentTeam: Team? = nil
    fileprivate(set) var roundIsOver: Bool = false
    fileprivate(set) var turnStateMachine: TurnStateMachine? = nil
    fileprivate(set) var unguessedEntries: [Entry]
    
    fileprivate let teams: [Team]
    
    init(teams: [Team]) {
        self.teams = teams
        unguessedEntries = DataService.allEntries
        
        super.init()
        currentTeam = nextTeam(currentTeam: currentTeam)
        turnStateMachine = TurnStateMachine(team: currentTeam!, entries: unguessedEntries)
    }
    
    func startNewTurn() {
        // Update from the last turn, if necessary
        if let turnStateMachine = turnStateMachine {
            currentTeam?.addToScore(turnStateMachine.numCorrect)
            currentTeam?.addToSkipped(turnStateMachine.numSkipped)
            unguessedEntries = unguessedEntries.filter{ !turnStateMachine.correctEntries.contains($0) }
        }
        
        if unguessedEntries.isEmpty {
            roundIsOver = true
        } else {
            currentTeam = nextTeam(currentTeam: currentTeam)
            turnStateMachine = TurnStateMachine(team: currentTeam!, entries: unguessedEntries)
        }
    }

    fileprivate func nextTeam(currentTeam: Team?) -> Team {
        if let currentTeam = currentTeam, let currentIndex = teams.index(of: currentTeam),
            teams.index(after: currentIndex) < teams.endIndex {
            
            return teams[teams.index(after: currentIndex)]
        }
        return teams.first!
    }
}
