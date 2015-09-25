//
//  LogoutViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 20/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController {
    
    func displayAlert(title:String, message:String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func logout(sender: AnyObject) {
    
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
           
            PFUser.logOutInBackgroundWithBlock { (error) -> Void in
                self.displayAlert("Error in logout", message: "\(error)")
            }
            self.performSegueWithIdentifier("logout", sender: self)
        
        })
        
        
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
