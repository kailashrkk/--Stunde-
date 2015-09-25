//
//  DietAddViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 19/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import Parse

class DietAddViewController: UIViewController {
    
    @IBOutlet weak var food: UITextField!
    @IBAction func addFood(sender: AnyObject) {
        if food.text == nil {
            println("No food entered")
            
            //            alert for not entering food
        } else{
//            foodArray.append(food.text)
//            NSUserDefaults.standardUserDefaults().setObject(foodArray, forKey: "foodArray")
            var gameScore = PFObject(className:"Diet")
            gameScore["food"] = food.text
            gameScore["userid"] = PFUser.currentUser()?.objectId!
          
            gameScore.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println(" The object has been saved.")
                } else {
                    println(error)
                }
            }
            
            performSegueWithIdentifier("back", sender: self)
            
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    func returnbutton(textField: UITextField!) -> Bool{
        food.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backer2(sender: AnyObject) {
        performSegueWithIdentifier("back2", sender: self)
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

