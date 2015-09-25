//
//  NewTableViewController.swift
//  Stunde
//
//  Created by Kailash Ramaswamy on 18/06/15.
//  Copyright (c) 2015 NCh. All rights reserved.
//

import UIKit
import EventKit
import Parse

class NewTableViewController: UITableViewController {
    
    
  
    @IBOutlet weak var setTitle: UITextField!
    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var date: UIDatePicker!
    var datepickerhidden = false
    
    var halo = true
    
    @IBOutlet weak var detailLabeltoo: UILabel!
    
    func displayAlert(title:String, message:String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
       
        dateChanged()
        date.addTarget(self, action: Selector("datechanging:"), forControlEvents: UIControlEvents.ValueChanged)
        dateChanged()
        date.addTarget(self, action: Selector("datechanging:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        detailLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        
        detailLabeltoo.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        
        date.alpha = 0
    }
    @IBAction func dateValue(sender: AnyObject) {
        if halo == true {
        
        dateChanged()
        } else {
        dateChanged()
        }
    }
    func datechanging(date: UIDatePicker){
        var dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
        if halo == true {
        var datevalue = dateformatter.stringFromDate(date.date)
        detailLabel.text = datevalue
        } else {
        var dateVaalue = dateformatter.stringFromDate(date.date)
        detailLabeltoo.text = dateVaalue
        }
    }
  
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        
        if setTitle.text == "" {
            displayAlert("Title is missing", message: "Please enter a title and record cycle")
        } else {
        var eventStore : EKEventStore = EKEventStore()
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
            granted, error in
            if (granted) && (error == nil) {
                println("granted \(granted)")
                println("error  \(error)")
                
                var event:EKEvent = EKEvent(eventStore: eventStore)
                
                var dateformat = NSDateFormatter()
                dateformat.dateFormat = "MMM-dd-yyyy"
                let date = dateformat.dateFromString(self.detailLabel.text!)
                let datetoo = dateformat.dateFromString(self.detailLabeltoo.text!)
              let datum = date!
                let datil = datetoo!
                
               dispatch_async(dispatch_get_main_queue(), { () -> Void in

               
                
                event.startDate = datum
                
                
                event.endDate = datil
                
                event.title = self.setTitle.text
                
                
                event.calendar = eventStore.defaultCalendarForNewEvents
                eventStore.saveEvent(event, span: EKSpanThisEvent, error: nil)
                println("Saved Event")
               self.displayAlert("Event saved", message: "Your event has been saved to your iPhone Calendar")
               
               })
                
               
                
            }
            
        })
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datepickerhidden && indexPath.section == 0 && indexPath.row == 1 {
           
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               self.date.alpha = 0
            })
            
            
            
            return 0
        } else {
            date.alpha = 1
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        
    }
    func toggleDatepicker(){
        datepickerhidden = !datepickerhidden
        
        date.alpha = 1
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            
        
            toggleDatepicker()
            halo = true
          
            
        } else if indexPath.section == 0 && indexPath.row == 2 {
            toggleDatepicker()
            halo = false
        }
    }
    
    func dateChanged(){
        
        if halo == true{
        detailLabel.text = NSDateFormatter.localizedStringFromDate(date.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
            
        } else {
            detailLabeltoo.text = NSDateFormatter.localizedStringFromDate(date.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
            
        }
        
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    func returnButton (textfield: UITextField!) ->Bool {
        setTitle.resignFirstResponder()
        return true
    }

}
