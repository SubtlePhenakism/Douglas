//
//  DetailViewController.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/13/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class DetailViewController: UIViewController {
    
    // Container to store the view table selected object
    var currentObject : PFObject?
    
    // Some text fields
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
        
        // Unwrap the current object object
        if let object = currentObject {
            propertyTitle.text = object["title"] as! String
            propertyAddress.text = object["address"] as! String
            city.text = object["city"] as! String
            state.text = object["state"] as! String
            zip.text = object["zip"] as! String
            
            var initialThumbnail = UIImage(named: "question")
            propertyImage.image = initialThumbnail
            if let thumbnail = object["propertyImage"] as? PFFile {
                propertyImage.file = thumbnail
                propertyImage.loadInBackground()
            }
        }
    }
}
