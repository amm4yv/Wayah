//
//  InfoViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/5/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var roundTitle = ["Anything Goes", "One Word", "Charades"]
    var roundDescription = ["In this round, you can say anything you need to (except the actual name) to get your team to guess the name.", "In this round, you can only say one word to get your team to guess the name.", "In this round, you can only act things out silently (charades) to get your team to guess the name."]
    
    override func viewWillAppear(animated: Bool) {
        if (Game.data.round <= 3) {
            titleLabel.text = "Round \(Game.data.round):\n\(roundTitle[Game.data.round-1])"
            infoLabel.text = roundDescription[Game.data.round-1]
            
        }
        
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
