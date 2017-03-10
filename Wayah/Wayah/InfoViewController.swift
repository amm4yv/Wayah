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
    
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance

    override func viewWillAppear(_ animated: Bool) {
        if let currentRound = gameStateMachine.currentRound, !gameStateMachine.gameIsOver {
            titleLabel.text = "Round \(currentRound.id):\n\(currentRound.title)"
            infoLabel.text = currentRound.description
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
