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

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var viewBottomSpacing: NSLayoutConstraint!
    
    @IBAction func addItemWithSender(_ sender: AnyObject) {
        DataService.addEntryWithName(textInput.text)
        textInput.text = nil
    }
    
    //MARK: - UIViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalItems.text = String(fetchedResultsController.fetchedObjects?.count ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.delegate = self
        if let titleText = titleLabel.attributedText?.string {
            titleLabel.attributedText = UIUtil.textWithStroke(text: titleText, color: Theme.Colors.dark)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UITextFieldDelegate
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addItemWithSender(textField)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.resignFirstResponder()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        totalItems.text = String(controller.fetchedObjects?.count ?? 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        GameStateMachine.sharedInstance.updateSettings(numEntries: fetchedResultsController.fetchedObjects?.count)
    }
    
    //MARK: - Helper Methods
    
    func endEditingNow(){
        self.view.endEditing(true)
    }
    
    func keyboardNotification(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            let animations = {
                if let endFrame = endFrame, endFrame.origin.y >= UIScreen.main.bounds.size.height {
                    self.view.frame.origin.y = 0.0
                } else if let endFrame = endFrame, endFrame.size.height > 0 {
                    self.view.frame.origin.y -= endFrame.size.height
                } else {
                    self.view.frame.origin.y = 0.0
                }
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: animations,
                           completion: nil)
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
