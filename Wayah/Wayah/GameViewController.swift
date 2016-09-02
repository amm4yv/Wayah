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
    var timer = NSTimer()
    
    var scores: [Int] = []
    //var teamScores = Scoreboard()
    
    var currentTeam = 1
    var itemIndex = abs(random()) % Game.data.bowl1.count
    var numCorrect = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var celebrityName: UILabel!
    
    @IBOutlet weak var scoreboard: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func selectCorrect(sender: UIButton) {
        
        scores[currentTeam-1] += 1
        Game.data.scores.increase(currentTeam-1)
        updateScores()
        
        print("Correct selected")
        if (Game.data.bowl1.count > 0) {
            Game.data.move(itemIndex)
        }
        
        // ROUND OVER
        if (Game.data.bowl1.count == 0) {
            Game.data.reset()
            if (Game.data.round > 3) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("Game Over") as! GameOverViewController
                self.presentViewController(vc, animated: true, completion: nil)
            } else {
                self.dismissViewControllerAnimated(true, completion: {})
            }
            
        } else {
            itemIndex = abs(random()) % Game.data.bowl1.count
            celebrityName.text = Game.data.bowl1[itemIndex].text
            numCorrect += 1
            correctLabel.text = "Correct: \(String(numCorrect))"
        }
    }
    
    @IBAction func selectSkip(sender: UIButton) {
        itemIndex = abs(random()) % Game.data.bowl1.count
        celebrityName.text = Game.data.bowl1[itemIndex].text
    }
    
    func decrement() {
        
        timerCount -= 1
        timerLabel.text = String(timerCount)
        
        // TURN OVER
        if (timerCount == 0) {
            timer.invalidate()
            timerRunning = false
            timerCount = Game.data.settings.timeLimit
            
            
            numCorrect = 0
            
            hide()
            
            currentTeam += 1
            if (currentTeam > Game.data.settings.numTeams) {
                currentTeam = 1
            }
            playButton.titleLabel?.text = "Team \(currentTeam) - Play!"
        }
        
    }
    
    func hide() {
        playButton.hidden = false
        celebrityName.hidden = true
        correctButton.hidden = true
        correctLabel.hidden = true
        skipButton.hidden = true
    }
    
    func unhide() {
        playButton.hidden = true
        celebrityName.text = Game.data.bowl1[itemIndex].text
        celebrityName.hidden = false
        
        correctButton.hidden = false
        correctLabel.hidden = false
        correctLabel.text = "Correct: \(String(numCorrect))"
        
        skipButton.hidden = !(Game.data.settings.allowSkipping!)
    }
    
    @IBAction func play(sender: UIButton) {
        
        unhide()
        
        if (timerRunning == false) {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameViewController.decrement), userInfo: nil, repeats: true)
            
            timerRunning = true
            
        }
        
        

        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        hide()
        
        scoreboard.numberOfLines = Game.data.settings.numTeams + 1
        scoreboard.sizeToFit()
        
        print("Score data: \(Game.data.scores.data.count)")
        
        if (Game.data.scores.data.count == 0) {
            Game.data.scores.create(Game.data.settings.numTeams)
            for _ in 1...Game.data.settings.numTeams {
                scores.append(0)
            }
        } else {
            for i in 1...Game.data.settings.numTeams {
                scores.append(Game.data.scores.data[i-1])
            }
        }
        
        
        
        updateScores()
        
        timerCount = Game.data.settings.timeLimit!
        timerLabel.text = String(timerCount)
        
    }
    
    func updateScores() {
        var text = "Scoreboard"
        for i in 1...Game.data.settings.numTeams {
            text += "\nTeam \(i): \(scores[i-1])"
        }
        
        scoreboard.text = text
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
