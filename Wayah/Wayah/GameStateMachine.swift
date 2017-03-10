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
    
    static let sharedInstance : GameStateMachine = {
        let instance = GameStateMachine()
        return instance
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    fileprivate(set) var settings = Settings()
    fileprivate(set) var currentRoundIndex: Int? = nil
    var currentRound: Round? {
        guard let index = currentRoundIndex else { return nil }
        return Rounds[index]
    }
    
    var scores = Scoreboard()
    var teams: [Team] = []
    
    fileprivate(set) var gameIsOver: Bool = false
    
    override init() {
        super.init()
        newGame()
    }
    
    // MARK: Access team
    
    func getFirstTeam() -> Team {
        return teams.first!
    }
    
    func getNextTeam(currentTeam: Team) -> Team {
        if let currentIndex = teams.index(of: currentTeam),
            teams.index(after: currentIndex) < teams.endIndex {
            
            return teams[teams.index(after: currentIndex)]
        }
        return teams.first!
    }
    
    func newGame() {
        currentRoundIndex = 0
        settings = Settings()
        scores = Scoreboard()
        for id in 1...settings.numTeams {
            teams.append(Team(id: id))
        }
    }
    
    func updateSettings(numTeams: String?, timeLimit: String?, allowSkipping: Bool) {
        guard let numTeams = numTeams, let timeLimit = timeLimit else { return }
        guard let numTeamsInt = Int(numTeams), let timeLimitInt = Int(timeLimit) else { return }
        
        settings = Settings(numTeams: numTeamsInt, timeLimit: timeLimitInt, allowSkipping: allowSkipping)
    }
    
    func roundOver() {
        currentRoundIndex = currentRoundIndex != nil ? currentRoundIndex! + 1 : nil
        
        if let roundIndex = currentRoundIndex, roundIndex >= Rounds.count {
            gameIsOver = true
            currentRoundIndex = nil
        }
    }
    
    var winner: Team? {
        return teams.max()
    }
    
}
