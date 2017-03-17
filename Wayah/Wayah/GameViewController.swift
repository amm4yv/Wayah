//
//  GameViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/4/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class ScoreBoard: UIView {
    
}

class GameViewController: UIViewController {
    
    var timerCount: Int = 60 {
        didSet {
            var timerString = String(timerCount)
            let ones = timerString.characters.popLast()!
            timerOnesPlace.text = String(ones)
            
            if let tens = timerString.characters.popLast() {
                timerTenthPlace.isHidden = false
                timerTenthPlace.text = String(tens)

            } else {
                timerTenthPlace.isHidden = true
            }
            
            if let hundreds = timerString.characters.popLast() {
                timerHundredthPlaceView.isHidden = false
                timerHundredthPlace.text = String(hundreds)
                
            } else {
                timerHundredthPlaceView.isHidden = true
            }
        }
    }
    
    var timerRunning = false
    var timer = Timer()
    
    var scores: [Int] = []
    
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    fileprivate var roundStateMachine: RoundStateMachine {
        return gameStateMachine.currentRoundStateMachine!
    }
    fileprivate var turnStateMachine: TurnStateMachine {
        return roundStateMachine.turnStateMachine!
    }
    
    @IBOutlet var roundNumberLabel: UILabel!
    @IBOutlet var teamNumberLabel: UILabel!
    @IBOutlet var roundTitle: UILabel!
    
    @IBOutlet var team1ScoreLabel: UILabel!
    @IBOutlet var team2ScoreLabel: UILabel!
    
    @IBOutlet var timerHundredthPlaceView: UIView!
    @IBOutlet var timerHundredthPlace: UILabel!
    @IBOutlet var timerTenthPlace: UILabel!
    @IBOutlet var timerOnesPlace: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var celebrityName: UILabel!
    
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var gamePlayView: UIView!
    
    @IBAction func selectCorrect(_ sender: UIButton) {
        turnStateMachine.entryGuessedCorrectly()
        
        if turnStateMachine.turnIsOver {
            turnOver()
            
        } else {
            update()
        }
    }
    
    @IBAction func selectSkip(_ sender: UIButton) {
        turnStateMachine.entrySkipped()
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timerCount = gameStateMachine.settings.timeLimit
        playButton.titleLabel?.text = "Team \(roundStateMachine.currentTeam!.id) - Play!"
        playButton.titleLabel?.sizeToFit()
        roundNumberLabel.text = "Round \(gameStateMachine.currentRound.id)"
        teamNumberLabel.text = "Team \(roundStateMachine.currentTeam!.id)"
        roundTitle.text = gameStateMachine.currentRound.title
        
        hide()
        update()
    }
    
    func decrement() {
        if timerCount > 0 {
            timerCount -= 1
        } else {
            turnOver()
        }
    }
    
    func turnOver() {
        timer.invalidate()
        timerRunning = false
        performSegue(withIdentifier: "showRoundReview", sender: self)
    }
    
    func hide() {
        playButton.isHidden = false
        gamePlayView.isHidden = true
    }
    
    func unhide() {
        playButton.isHidden = true
        gamePlayView.isHidden = false
        update()
    }
    
    @IBAction func play(_ sender: UIButton) {
        unhide()
        if !timerRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.decrement), userInfo: nil, repeats: true)
            timerRunning = true

        } else {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.decrement), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidLoad() {
        skipButton.isHidden = !gameStateMachine.settings.allowSkipping
    }
    
    func update() {
        if let currentTeam = gameStateMachine.currentRoundStateMachine?.currentTeam {
            if currentTeam.id == 1 {
                team1ScoreLabel.text = String(currentTeam.score)
                
            } else if currentTeam.id == 2 {
                team2ScoreLabel.text = String(currentTeam.score)

            }
        }
        
        celebrityName.text = turnStateMachine.currentEntry.name
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let reviewViewController = segue.destination as? TurnReviewViewController {
//
//        }
//    }
    
}
