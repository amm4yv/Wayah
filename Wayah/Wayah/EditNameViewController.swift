//
//  EditNameViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 9/1/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class EditNameViewController: UITableViewController {
    
    @IBOutlet var editTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        tableView.registerClass(EditNameViewCell.self, forCellReuseIdentifier: "editNameCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
    
    override func viewWillAppear(animated: Bool){

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Game.data.bowl1.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("editNameCell", forIndexPath: indexPath) as! EditNameViewCell
        
        // Configure the cell...
        let item = Game.data.bowl1[indexPath.row]
        cell.listItems = item
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.userInteractionEnabled = true
        
        return cell
    }
    
    
    
    //        override func tableView(tableView: UITableView,
    //            estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //                return 75;
    //        }
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        //Return NO if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let _ = tableView.dequeueReusableCellWithIdentifier("editNameCell", forIndexPath: indexPath) as! EditNameViewCell

        let alert = UIAlertController(title: "Edit Name", message: nil, preferredStyle: UIAlertControllerStyle.Alert)

        alert.addTextFieldWithConfigurationHandler { (textField : UITextField) -> Void in
            textField.text = Game.data.bowl1[indexPath.row].text
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive) { (result : UIAlertAction) -> Void in
            Game.data.bowl1.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            Game.data.update((alert.textFields?.first?.text!)!, index: indexPath.row)
            self.tableView.reloadData()
        }
        alert.addAction(deleteAction)
        alert.addAction(saveAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            Game.data.bowl1.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            //game.bowl1.append(<#newElement: T#>)
            
        }
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

