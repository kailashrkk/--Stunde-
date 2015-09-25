//
//  AddActivityViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 19/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import Parse
import iAd


class AddActivityViewController: UIViewController {
    
    
    
    @IBAction func recordActivity(sender: AnyObject) {
        if duration.text != nil && activity.text != nil {
//            
//            activityFeatures.append(activity.text)
//            activityTimes.append(duration.text)
            
            var date = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle) as! String
         
//            daten.append(date)
//            
            var gameScore = PFObject(className:"Active")
            gameScore["activity"] = activity.text
             gameScore["duration"] = duration.text
            gameScore["userid"] = PFUser.currentUser()?.objectId!
            gameScore["date"] = date
            
            gameScore.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println(" The object has been saved.")
                } else {
                    println(error)
                }
            }
//
//            NSUserDefaults.standardUserDefaults().setObject(activityFeatures, forKey: "activityFeatures")
//            NSUserDefaults.standardUserDefaults().setObject(activityTimes, forKey: "activityTimes")
//            NSUserDefaults.standardUserDefaults().setObject(daten, forKey: "datez")
            
            performSegueWithIdentifier("back2", sender: self)
            
            
            
            
        } else{
            println("There was an error")
        }
        
        
    }
    
    @IBAction func backer(sender: AnyObject) {
        
        performSegueWithIdentifier("back1", sender: self)
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var activity: UITextField!
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
