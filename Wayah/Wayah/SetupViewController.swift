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

    var allowSkipping = true
    
    
    @IBAction func teamStepperValueChanged(sender: UIStepper) {
        teamValue.text = Int(sender.value).description
    }
    
    @IBAction func timeStepperValueChanged(sender: UIStepper) {
        timeValue.text = Int(sender.value).description
    }
    
    @IBAction func skippingValueChanged(sender: UISwitch) {
        allowSkipping = !allowSkipping
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Submit" {
            print("submit", terminator: "")
            Game.data.settings = Settings(t: Int(teamValue.text!)!, l: Int(timeValue.text!)!, s: allowSkipping)
        }
    }
    
    
    @IBAction func didSubmit(sender: AnyObject) {
        print("submit", terminator: "")
        Game.data.settings = Settings(t: Int(teamValue.text!)!, l: Int(timeValue.text!)!, s: allowSkipping)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamStepper.wraps = true
        teamStepper.autorepeat = true
        
        timeStepper.wraps = true
        timeStepper.autorepeat = true
        

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
