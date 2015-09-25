//
//  DietTableViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 19/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import Parse
import iAd

var foodArray: [String] = []
var mirage: [String] = [""]

class DietTableViewController: UITableViewController, UITableViewDelegate {
    
    
    
    @IBOutlet var foodArrayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if NSUserDefaults.standardUserDefaults().objectForKey("foodArray") != nil {
//            foodArray = NSUserDefaults.standardUserDefaults().objectForKey("foodArray") as! [String]
        
        mirage.removeAll(keepCapacity: true)
        self.canDisplayBannerAds = true
        var qoory = PFQuery()
        qoory.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let users = objects {
                foodArray.removeAll(keepCapacity: true)
            }
        
        
        var query = PFQuery(className: "Diet")
        query.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                
                for object in objects {
                  
                    var foodyum = object["food"] as! String
                    
                    println(foodyum)
                    
                    mirage.append(foodyum)
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.foodArrayTable.reloadData()
                    })
                }
            }
        }
    }
        

    }
    override func viewDidAppear(animated: Bool) {
        self.foodArrayTable.reloadData()
      println(foodArray)
        
    }
    func displayAlert(title:String, message:String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logout1", sender: self)
        
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
       return mirage.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if mirage.count > 1 {
        
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
           
           
            mirage.removeAtIndex(indexPath.row)
            
            self.foodArrayTable.reloadData()
            
            var query = PFQuery(className: "Diet")
            query.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    
                    for object in objects {
                        object.whereKey("food", equalTo: mirage[indexPath.row])
                        object.deleteEventually()
                    }
                    
                }
                
            }
        
            }
        } else {
            displayAlert("Cannot delete", message: "A minimum of one entry must be present")
        }
}
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("diet", forIndexPath: indexPath) as! UITableViewCell
        
//        cell.textLabel?.text = foodArray[indexPath.row]
//        NSUserDefaults.standardUserDefaults().setObject(foodArray, forKey: "foodArray")
     
        
      
        
      
            cell.textLabel?.text = mirage[indexPath.row]
     
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
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
