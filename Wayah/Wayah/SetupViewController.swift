//
//  SetupViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 4/24/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var teamValue: UILabel!
    @IBOutlet weak var teamStepper: UIStepper!
    
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!

    fileprivate var allowSkipping = true
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    
    @IBAction func teamStepperValueChanged(_ sender: UIStepper) {
        teamValue.text = Int(sender.value).description
    }
    
    @IBAction func timeStepperValueChanged(_ sender: UIStepper) {
        timeValue.text = Int(sender.value).description
    }
    
    @IBAction func skippingValueChanged(_ sender: UISwitch) {
        allowSkipping = !allowSkipping
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Submit" {
            print("submit", terminator: "")
            gameStateMachine.updateSettings(numTeams: teamValue.text, timeLimit: timeValue.text, allowSkipping: allowSkipping)
        }
    }
    
    
    @IBAction func didSubmit(_ sender: AnyObject) {
        print("submit", terminator: "")
        gameStateMachine.updateSettings(numTeams: teamValue.text, timeLimit: timeValue.text, allowSkipping: allowSkipping)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamStepper.wraps = true
        teamStepper.autorepeat = true
        
        timeStepper.wraps = true
        timeStepper.autorepeat = true
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
