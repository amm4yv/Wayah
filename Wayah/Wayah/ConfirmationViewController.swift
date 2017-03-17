//
//  ConfirmationViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/4/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import CoreData
import UIKit

class ConfirmationViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var namesInBowl: UILabel!
    
    @IBOutlet weak var timeLimit: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!
    
    var allowSkipping = true
    
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    
    @IBAction func timeStepperValueChanged(_ sender: UIStepper) {
        timeLimit.text = Int(sender.value).description
    }
    
    @IBAction func skippingValueChanged(_ sender: UISwitch) {
        allowSkipping = !allowSkipping
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLimit.text = String(gameStateMachine.settings.timeLimit)
        namesInBowl.text = String(gameStateMachine.settings.numEntries)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gameStateMachine.newGame()
        gameStateMachine.updateSettings(numTeams: 2, timeLimit: Int(timeStepper.value), allowSkipping: allowSkipping)
    }
}
