//
//  InfoViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/5/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        var info = ""
        for team in gameStateMachine.teams {
            info += String(format: "\nTeam %d: %d", team.id, team.score)
        }
        
        if let winner = gameStateMachine.winner {
            info += String(format: "\nTeam %d wins!", winner.id)
        }
            
        infoLabel.text = info
    }
    
}
