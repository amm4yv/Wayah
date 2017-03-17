//
//  ViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 4/24/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var wayahLogo: UILabel!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var howToPlay: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startNewGame" {
            DataService.deleteAllEntries()
            GameStateMachine.sharedInstance = GameStateMachine()
        }
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue) {
        
    }
    
}

