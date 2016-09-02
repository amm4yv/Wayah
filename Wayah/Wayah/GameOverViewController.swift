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
    
    override func viewWillAppear(animated: Bool) {
            var info = ""
            var highest = 0
            var winner = ""
            for i in 1...Game.data.settings.numTeams {
                let score = Game.data.scores.data[i-1]
                info += "\nTeam \(i): \(score)"
                if (score > highest) {
                    highest = score
                    winner = "Team \(i)"
                }
            }
            
            info += "\n\(winner) wins!"
            
            infoLabel.text = info
            Game.data.newGame()
        }
        
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goHomeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
