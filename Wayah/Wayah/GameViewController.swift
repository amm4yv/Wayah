//
//  GameViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/4/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var timerCount: Int = 60
    var timerRunning = false
    var timer = Timer()
    
    var scores: [Int] = []
    
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    fileprivate let roundStateMachine = RoundStateMachine()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var celebrityName: UILabel!
    
    @IBOutlet weak var scoreboard: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func selectCorrect(_ sender: UIButton) {
        roundStateMachine.entryGuessedCorrectly()
        
        if gameStateMachine.gameIsOver {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Game Over") as! GameOverViewController
            self.present(vc, animated: true, completion: nil)
            
        } else if !roundStateMachine.roundIsOver {
            update()
            
        } else {
            self.dismiss(animated: true, completion: {})
        }
    }
    
    @IBAction func selectSkip(_ sender: UIButton) {
        roundStateMachine.entrySkipped()
        update()
    }
    
    func decrement() {
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = String(timerCount)
        } else {
            // TURN OVER
            timer.invalidate()
            timerRunning = false
            timerCount = gameStateMachine.settings.timeLimit
            
            roundStateMachine.endTurn()
            hide()

            playButton.titleLabel?.text = "Team \(roundStateMachine.currentTeam.id) - Play!"
            playButton.titleLabel?.sizeToFit()
        }
        
    }
    
    func hide() {
        playButton.isHidden = false
        celebrityName.isHidden = true
        correctButton.isHidden = true
        correctLabel.isHidden = true
        skipButton.isHidden = true
    }
    
    func unhide() {
        playButton.isHidden = true
        celebrityName.text = roundStateMachine.currentEntry.name
        celebrityName.isHidden = false
        
        correctButton.isHidden = false
        correctLabel.isHidden = false
        correctLabel.text = "Correct: \(String(roundStateMachine.numCorrect))"
        
        skipButton.isHidden = !gameStateMachine.settings.allowSkipping
    }
    
    @IBAction func play(_ sender: UIButton) {
        unhide()
        
        if (timerRunning == false) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.decrement), userInfo: nil, repeats: true)
            
            timerRunning = true
        } else {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.decrement), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hide()
        
        scoreboard.numberOfLines = gameStateMachine.settings.numTeams + 1
        scoreboard.sizeToFit()
        
        update()
        
        timerCount = gameStateMachine.settings.timeLimit
        timerLabel.text = String(timerCount)
    }
    
    func update() {
        var text = "Scoreboard"
        for team in gameStateMachine.teams {
            text += String(format: "\nTeam %d: %d", team.id, team.score)
        }
        
        scoreboard.text = text
        
        celebrityName.text = roundStateMachine.currentEntry.name
        correctLabel.text = "Correct: \(String(roundStateMachine.numCorrect))"
    }
    
}
