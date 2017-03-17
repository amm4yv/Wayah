//
//  GameStateMachine.swift
//  Wayah
//
//  Created by Allison Moyer on 3/9/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import CoreData
import Foundation
import UIKit

struct Settings {
    var allowSkipping: Bool
    var numEntries: Int
    var numTeams: Int
    var timeLimit: Int
}

struct Round {
    var id: Int
    var title: String
    var description: String
}

fileprivate let Rounds: [Round] = [
    Round(id: 1, title: "Anything Goes", description: "In this round, you can say anything you need to (except the actual name) to get your team to guess the name."),
    Round(id: 2, title: "One Word", description: "In this round, you can only say one word to get your team to guess the name."),
    Round(id: 3, title: "Charades", description: "In this round, you can only act things out silently (charades) to get your team to guess the name.")
]

class GameStateMachine: NSObject {
    
    static var sharedInstance : GameStateMachine = GameStateMachine()
    
    fileprivate(set) var settings: Settings
    fileprivate(set) var currentRoundIndex: Int = 0
    var currentRound: Round {
        return Rounds[currentRoundIndex]
    }
    fileprivate(set) var currentRoundStateMachine: RoundStateMachine? = nil
    
    var teams: [Team] = []
    
    fileprivate(set) var gameIsOver: Bool = false
    
    override init() {
        self.settings = Settings(allowSkipping: true, numEntries: 0, numTeams: 2, timeLimit: 60)
        
        super.init()
    }
    
    // MARK: Public Methods
    
    func newGame() {
        currentRoundIndex = 0
        settings = defaultSettings
        for id in 1...settings.numTeams {
            teams.append(Team(id: id))
        }
        currentRoundStateMachine = RoundStateMachine(teams: teams)
    }
    
    func updateSettings(numEntries: Int? = nil, numTeams: Int? = nil, timeLimit: Int? = nil, allowSkipping: Bool? = nil) {
        if let numEntries = numEntries {
            settings.numEntries = numEntries
        }
        
        if let numTeams = numTeams {
            settings.numEntries = numTeams
        }
        
        if let timeLimit = timeLimit {
            settings.timeLimit = timeLimit
        }
        
        if let allowSkipping = allowSkipping {
            settings.allowSkipping = allowSkipping
        }
    }
    
    func startNewRound() {
        currentRoundStateMachine = RoundStateMachine(teams: teams)
        currentRoundIndex += 1
        
        if currentRoundIndex >= Rounds.count {
            gameIsOver = true
            currentRoundIndex = 0
        }
    }
    
    var winner: Team? {
        return teams.max()
    }
    
    var defaultSettings: Settings {
        return Settings(allowSkipping: true, numEntries: 0, numTeams: 2, timeLimit: 60)
    }
    
}
