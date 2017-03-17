//
//  TurnReviewViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 3/10/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import Foundation
import UIKit


class TurnReviewViewController: UIViewController {
    
    @IBOutlet var roundTitle: UILabel!
    @IBOutlet var roundDescription: UILabel!
    @IBOutlet var teamTitle: UILabel!
    @IBOutlet var numberCorrectLabel: UILabel!
    @IBOutlet var numberSkippedLabel: UILabel!
        
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    fileprivate var roundStateMachine: RoundStateMachine {
        return gameStateMachine.currentRoundStateMachine!
    }
    fileprivate var turnStateMachine: TurnStateMachine {
        return roundStateMachine.turnStateMachine!
    }
        
    @IBAction func looksGoodPressed(_ sender: Any) {
        roundStateMachine.startNewTurn()
        
        if roundStateMachine.roundIsOver {
            gameStateMachine.startNewRound()

            if gameStateMachine.gameIsOver {
                performSegue(withIdentifier: "gameOver", sender: self)
                return
                
            } else {
                performSegue(withIdentifier: "UnwindToInfoViewControllerSegue", sender: self)
            }
        }
        
        dismiss(animated: true, completion: nil)        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        roundTitle.text = "Round \(gameStateMachine.currentRound.id)"
        roundDescription.text = gameStateMachine.currentRound.title
        teamTitle.text = "Team \(roundStateMachine.currentTeam!.id)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numberCorrectLabel.text = String(describing: turnStateMachine.numCorrect)
        numberSkippedLabel.text = String(describing: turnStateMachine.numSkipped)
    }
    
}
