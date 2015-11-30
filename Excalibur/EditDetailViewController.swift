//
//  EditDetailViewController.swift
//  Excalibur
//
//  Created by Robert Passemar on 10/19/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class EditDetailViewController: UIViewController {
    
    var currentObject : PFObject?
    
    @IBOutlet weak var propertyTitle: UITextField!
    @IBOutlet weak var propertyAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var propertyImage: PFImageView!
    
    // The save button
    @IBAction func saveButton(sender: AnyObject) {
        
        if let updateObject = currentObject as PFObject? {
            
            // Update the existing parse object
            updateObject["title"] = propertyTitle.text
            updateObject["address"] = propertyAddress.text
            updateObject["city"] = city.text
            updateObject["state"] = state.text
            updateObject["zip"] = zip.text
            
            // Save the data back to the server in a background task
            updateObject.saveEventually()
        } else {
            
            // Create a new parse object
            var updateObject = PFObject(className:"Property")
            
            updateObject["title"] = propertyTitle.text
            updateObject["address"] = propertyAddress.text
            updateObject["city"] = city.text
            updateObject["state"] = state.text
            updateObject["zip"] = zip.text
            updateObject.ACL = PFACL(user: PFUser.currentUser()!)
            
            // Save the data back to the server in a background task
            updateObject.saveEventually()
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
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
