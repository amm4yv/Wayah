//
//  ConfirmationViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/4/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var numberTeams: UILabel!
    @IBOutlet weak var timeLimit: UILabel!
    @IBOutlet weak var allowSkipping: UILabel!
    @IBOutlet weak var namesInBowl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Game.data.settings.numTeams, terminator: "")
        
        numberTeams.text = String(Game.data.settings.numTeams)
        timeLimit.text = String(Game.data.settings.timeLimit)
        if (Game.data.settings.allowSkipping!) {
            allowSkipping.text = "Yes"
        }
        else {
            allowSkipping.text = "No"
        }
        
        namesInBowl.text = String(Game.data.bowl1.count)
        
        Game.data.scores.create(Game.data.settings.numTeams)

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
