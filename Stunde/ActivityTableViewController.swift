//
//  ActivityTableViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 19/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import Parse
import iAd

var activityFeatures: [String] = []
var activityTimes: [String] = []


var miragly: [String] = ["Run"]
var mivagly: [String] = ["20"]
var datel: [String] = ["Jun 22, 2015"]

class ActivityTableViewController: UITableViewController {
    @IBOutlet var activityTable: UITableView!
    

    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        performSegueWithIdentifier("logout2", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miragly.removeAll(keepCapacity: true)
        mivagly.removeAll(keepCapacity: true)
        datel.removeAll(keepCapacity: true)
        self.canDisplayBannerAds = true
        

//
//        if NSUserDefaults.standardUserDefaults().objectForKey("activityFeatures") != nil{
//            
//            activityFeatures = NSUserDefaults.standardUserDefaults().objectForKey("activityFeatures") as! [String]
//            activityTimes = NSUserDefaults.standardUserDefaults().objectForKey("activityTimes") as! [String]
//            
//            daten = NSUserDefaults.standardUserDefaults().objectForKey("datez") as! [String]
//        
//        } else{
//            performSegueWithIdentifier("add", sender: self)
//        }
//        
//      
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        miragly.removeAll(keepCapacity: true)
        mivagly.removeAll(keepCapacity: true)
        datel.removeAll(keepCapacity: true)
        
        var query = PFQuery(className: "Active")
        query.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                
                for object in objects {
                    
                    var foodyum = object["activity"] as! String
                    
                    var foodyu = object["duration"] as! String
                    
                    var foody = object["date"] as! String
                    
                    
                    
                    mivagly.append(foodyu)
                   
                    miragly.append(foodyum)
                    
                    datel.append(foody)
                    
                self.activityTable.reloadData()
                }
            }
        }
//        var queryo = PFQuery(className: "Active")
//        queryo.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
//        queryo.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if let objects = objects {
//                
//                for object in objects {
//                    
//                    var foodyum = object["duration"] as! String
//                    
//                    println(foodyum)
//                    
//                    mivagly.append(foodyum)
//                        
//                        self.activityTable.reloadData()
//                   
//                }
//            }
//        }
//        
//        var queryio = PFQuery(className: "Active")
//        queryio.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
//        queryio.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if let objects = objects {
//                
//                for object in objects {
//                    
//                    var foodyum = object["date"] as! String
//                    
//                    println(foodyum)
//                
//                    datel.append(foodyum)
//                    
//                        self.activityTable.reloadData()
//                    
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
//        
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            
////            activityFeatures.removeAtIndex(indexPath.row)
////            activityTimes.removeAtIndex(indexPath.row)
////            daten.removeAtIndex(indexPath.row)
////            NSUserDefaults.standardUserDefaults().setObject(activityFeatures, forKey: "activityFeatures")
////            NSUserDefaults.standardUserDefaults().setObject(activityTimes, forKey: "activityTimes")
////            NSUserDefaults.standardUserDefaults().setObject(daten, forKey: "datez")
////            miragely.removeAtIndex(indexPath.row)
////            mivagely.removeAtIndex(indexPath.row)
////            daten.removeAtIndex(indexPath.row)
////            
////            var query = PFQuery(className: "Active")
////            query.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
////            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
////                if let objects = objects {
////                    
////                    for object in objects {
////                        object.whereKey("activity", equalTo: miragely[indexPath.row])
////                        object.deleteEventually()
////                    }
////                    
////                }
////                
////            }
////           
////            
////            var queryi = PFQuery(className: "Active")
////            queryi.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
////            queryi.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
////                if let objects = objects {
////                    
////                    for object in objects {
////                        object.whereKey("duration", equalTo: mivagely[indexPath.row])
////                        object.deleteEventually()
////                    }
////                    
////                }
////                
////            }
////            var queryio = PFQuery(className: "Active")
////            queryio.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
////            queryio.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
////                if let objects = objects {
////                    
////                    for object in objects {
////                        object.whereKey("date", equalTo: daten[indexPath.row])
////                        object.deleteEventually()
////                    }
////                    
////                }
////                
////            }
//          
//            
//            
//            activityTable.reloadData()
//        }
//        
//        
//        
//        
//    }
//
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if miragly.count == mivagly.count {
        
        return miragly.count
        } else {
            
            return 3
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mycell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ActivityTableViewCell
        
        mycell.activity.text = miragly[indexPath.row]
        
        
        mycell.duration.text = mivagly[indexPath.row]
        
        mycell.date.text = datel[indexPath.row]
//
//        NSUserDefaults.standardUserDefaults().setObject(activityFeatures, forKey: "activityFeatures")
//        NSUserDefaults.standardUserDefaults().setObject(activityTimes, forKey: "activityTimes")
//        NSUserDefaults.standardUserDefaults().setObject(daten, forKey: "datez")
        
     
        
       
        return mycell
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
