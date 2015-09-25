//
//  LoginViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 19/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBAction func login(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(email.text, password:password.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("login", sender: self)
            } else {
                self.displayAlert("Login attempt unsuccessful", message: "\(error)")
            }
        }
        
        
        
    }
    @IBAction func signup(sender: AnyObject) {
        
        var user = PFUser()
        
        user.password = password.text
        user.username = email.text
     
        if email.text != nil && password.text != nil {
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                self.displayAlert("There was an error", message: "\(errorString)")
                
            } else {
               self.performSegueWithIdentifier("login", sender: self)
            }
        }
        } else {
            displayAlert("Login credentials absent", message: "Please enter valid email and password and try again")
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
    
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func displayAlert(title:String, message:String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}
