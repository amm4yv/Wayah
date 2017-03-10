//
//  InputViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 4/25/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import CoreData
import UIKit

class InputViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var totalItems: UILabel!
    
    @IBAction func addItemWithSender(sender: AnyObject) {
        DataService.addEntryWithName(textInput.text)
        textInput.text = nil
    }
    
    //MARK: - Helper Methods
    
    func resign() {
        self.resignFirstResponder()
    }

    func endEditingNow(){
        self.view.endEditing(true)
    }
    
    //MARK: - Delegate Methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.
        let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(InputViewController.endEditingNow))
        let toolbarButtons = [item]
        
        //Put the buttons into the ToolBar and display the tool bar
        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
    
    private func textFieldDidEndEditing(textField: UITextField) {
        resign()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resign()
        return true
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        totalItems.text = String(controller.fetchedObjects?.count ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalItems.text = String(fetchedResultsController.fetchedObjects?.count ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(InputViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(InputViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
//        NotificationCenter.default.addObserver(self, selector: #selector(InputViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(InputViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Entry> = {
        let fetchRequest: NSFetchRequest<Entry> = NSFetchRequest(entityName: "Entry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.context, sectionNameKeyPath: nil, cacheName: nil)        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

}
