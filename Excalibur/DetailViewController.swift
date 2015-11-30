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
    var tName : String?
    
    
    @IBOutlet weak var propertyTitleLabel: UILabel!
    @IBOutlet weak var propertyAddressLabel: UILabel!
    @IBOutlet weak var propertyCityLabel: UILabel!
    @IBOutlet weak var propertyStateLabel: UILabel!
    @IBOutlet weak var propertyZipLabel: UILabel!
    @IBOutlet weak var propertyImageLabel: PFImageView!
    @IBOutlet weak var currentTenantName: UILabel!
    
    @IBOutlet weak var propertyTitle: UITextField!
    @IBOutlet weak var propertyAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var propertyImage: PFImageView!
    
    @IBOutlet weak var tenantUserImage: PFImageView!
    
    @IBOutlet weak var tenantCodeField: UITextField!
    
    @IBAction func updateTenantCodeAction(sender: AnyObject) {
        if let updateCode = currentObject as PFObject? {
            updateCode["tenantCode"] = tenantCodeField.text
            updateCode.saveInBackground()
        }
    }
    
    var currentTenant : PFUser?
    
    
    // The save button
    @IBAction func saveButton(sender: AnyObject) {
        
        if let updateObject = currentObject as PFObject? {
            
            // Update the existing parse object
            updateObject["title"] = propertyTitle.text
            updateObject["address"] = propertyAddress.text
            updateObject["city"] = city.text
            updateObject["state"] = state.text
            //updateObject["zip"] = zip.text
            
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
        
        println("hi")
        println(currentObject)
        println("this is the current tenants name")
        println(tName)
        currentTenantName.text = tName
        
        
        
        // Unwrap the current object
        
        
        
        if let object = currentObject {
            propertyTitleLabel.text = object["title"] as? String
            self.propertyAddressLabel.text = object["address"] as? String
            self.propertyCityLabel.text = object["city"] as? String
            self.propertyStateLabel.text = object["state"] as? String
            self.propertyZipLabel.text = object["zip"] as? String
            self.currentTenant = object["currentTenant"] as? PFUser
            self.tenantCodeField.placeholder = object["tenantCode"] as? String
            println("current tenant test")
            println(currentTenant)
            
            if let dude = object["currentTenant"] as? PFUser {
                self.currentTenantName.text = dude.username
                println(currentTenantName)
                //println(currentTenant?.username)
            }
            //self.currentTenantName.text = (name as? String)!
//            if let contract = object["currentContract"] as? PFObject {
//                if let lessee = contract["lessee"] as? PFUser {
//                    println("lessee =")
//                    println(lessee.objectId)
//                    let usernameQuery = PFUser.query()
//                    usernameQuery?.includeKey("username")
//                    usernameQuery?.whereKey("objectId", equalTo: lessee.objectId!)
//                    usernameQuery?.findObjectsInBackgroundWithBlock({ (items:[AnyObject]?, error:NSError?) -> Void in
//                        println("test")
//                    })
//                    println(usernameQuery)
//                    var results = usernameQuery
//                    println(results)
//                    }

                    //var userId = lessee.objectId
//                    var userQuery = PFUser.query()
//                    userQuery?.includeKey("username")
//                    userQuery?.whereKey("objectId", equalTo:lessee.objectId!)
//                    println(lessee.objectId)
//                    //println(userId)
//                    
//                    println(lessee)
                    
//                }
                
                //if let username = lessee.userQuery?
            
            //println(object["currentContract"].objectForKey("lessee"))
            //println(object["currentContract"])
            //self.currentTenantName.text = object["lessee"] as? String
            
            var initialPropertyThumbnail = UIImage(named: "home60")
            self.propertyImageLabel.image = initialPropertyThumbnail
            if let propertyThumbnail = object["image"] as? PFFile {
                self.propertyImageLabel.file = propertyThumbnail
                self.propertyImageLabel.loadInBackground()
            }
            
//            var initialTenantThumbnail = UIImage(named: "question")
//            self.tenantUserImage.image = initialTenantThumbnail
//            if (currentTenant != PFUser.currentUser()) {
//                let tenantQuery = PFUser.query()
//                tenantQuery?.valueForKey("username")
//                tenantQuery?.valueForKey("image")
//                tenantQuery?.findObjects()
//            }
//            
//            if let tenantThumbnail = currentTenant["image"] as! PFFile? {
//                self.tenantUserImage.file = tenantThumbnail
//                self.tenantUserImage.loadInBackground()
//            }
        }
        
        var initialTenantThumbnail = UIImage(named: "question")
        self.tenantUserImage.image = initialTenantThumbnail
        var currentTenantImage : PFFile
        if let info = currentTenant {
            if let currentTenantImage = info["image"] as? PFFile {
                self.tenantUserImage.file = currentTenantImage
                self.tenantUserImage.loadInBackground()
            }
        }
//        if let tenantImage = currentTenant["image"] as? PFFIle {
//            self.tenantUserImage.file = tenantImage
//            self.tenantUserImage.loadInBackground()
//        }
    }
}
