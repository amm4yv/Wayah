//
//  InputViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 4/25/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    //var items = Data().items;
    

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var totalItems: UILabel!
    
    @IBAction func addItem(sender: AnyObject) {
        if !(textInput.text ?? "").isEmpty {
            Game.data.add(BowlItem(text: textInput.text!))
            totalItems.text = String(Game.data.bowl1.count)
            textInput.text = ""
            print (Game.data.bowl1, terminator: "")
        }
    }
    
    //MARK: - Helper Methods
    
    // This is called to remove the first responder for the text field.
    func resign() {
        self.resignFirstResponder()
    }
    
    // This triggers the textFieldDidEndEditing method that has the textField within it.
    //  This then triggers the resign() method to remove the keyboard.
    //  We use this in the "done" button action.
    func endEditingNow(){
        self.view.endEditing(true)
    }
    
    
    //MARK: - Delegate Methods
    
    // When clicking on the field, use this method.
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.
        let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InputViewController.endEditingNow) )
        let toolbarButtons = [item]
        
        //Put the buttons into the ToolBar and display the tool bar
        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
    
    // What to do when a user finishes editting
    func textFieldDidEndEditing(textField: UITextField) {
        
        //nothing fancy here, just trigger the resign() method to close the keyboard.
        resign()
    }
    
    
    // Clicking away from the keyboard will remove the keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // called when 'return' key pressed. return NO to ignore.
    // Requires having the text fields using the view controller as the delegate.
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        // Sends the keyboard away when pressing the "done" button
        resign()
        return true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        totalItems.text = String(Game.data.bowl1.count)
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
