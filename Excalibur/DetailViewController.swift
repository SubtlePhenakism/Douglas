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
    
    @IBOutlet weak var imageToUpload: UIImageView!
    //var imageToUpload: UIImageView!
    
    @IBOutlet weak var propertyImageView: PFImageView!
    @IBOutlet weak var propertyTitleField: UITextField!
    @IBOutlet weak var propertyAddressField: UITextField!
    @IBOutlet weak var propertyCityField: UITextField!
    @IBOutlet weak var propertyStateField: UITextField!
    @IBOutlet weak var propertyZipcodeField: UITextField!
    
    @IBOutlet weak var tenantImageView: PFImageView!
    @IBOutlet weak var tenantName: UILabel!
    @IBOutlet weak var tenantCodeField: UITextField!
    
    @IBAction func changeImageButton(sender: AnyObject) {
        //Open a UIImagePickerController to select the picture
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func updateTenantCodeButton(sender: AnyObject) {
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
//            var alertController = UIAlertController(
//                title:"Confirm Changes", message:"Are you sure you want to change this property info?", preferredStyle: UIAlertControllerStyle.Alert
//            )
//            var saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action) -> Void in
        
        let pictureData = UIImagePNGRepresentation(imageToUpload.image!)
//        
//        //Upload a new picture
//        //1
//        let file = PFFile(name: "image", data: pictureData)
//        file.saveInBackground()
        
                if let updateObject = self.currentObject as PFObject? {
                    if (self.propertyTitleField.text != "") {
                        updateObject["title"] = self.propertyTitleField.text
                    }
                    if (self.propertyAddressField.text != "") {
                        updateObject["address"] = self.propertyAddressField.text
                    }
                    if (self.propertyCityField.text != "") {
                        updateObject["city"] = self.propertyCityField.text
                    }
                    if (self.propertyStateField.text != "") {
                        updateObject["state"] = self.propertyStateField.text
                    }
                    if (self.propertyZipcodeField.text != "") {
                        updateObject["zip"] = self.propertyZipcodeField.text
                    }
                    if (self.imageToUpload != nil) {
                        updateObject["image"] = PFFile(name: "image", data: pictureData)
                        print("image has value")
                    }
                    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                    spinner.startAnimating()
                    updateObject.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if ((error) != nil) {
                            var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "Ok")
                            alert.show()
                            spinner.stopAnimating()
                        } else {
                            spinner.stopAnimating()
                            var alert = UIAlertView(title: "Success", message: "Your changes have been saved", delegate: self, cancelButtonTitle: "Ok")
                            alert.show()
                        }
                    })
//                    updateObject.saveInBackgroundWithBlock({ (success, error) -> Void in
//                        if ((error) == nil) {
//                            var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
//                            alert.show()
//                        } else {
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                let viewController:UIViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewControllerWithIdentifier("Nav") as! UIViewController
//                                self.presentViewController(viewController, animated: true, completion: nil)
//                            })
//                        }
//                    })
//               }
            }
    }
    
    
    
//    var tName : String?
//    
//    
//    @IBOutlet weak var propertyTitleLabel: UILabel!
//    @IBOutlet weak var propertyAddressLabel: UILabel!
//    @IBOutlet weak var propertyCityLabel: UILabel!
//    @IBOutlet weak var propertyStateLabel: UILabel!
//    @IBOutlet weak var propertyZipLabel: UILabel!
//    @IBOutlet weak var propertyImageLabel: PFImageView!
//    @IBOutlet weak var currentTenantName: UILabel!
//    
//    @IBOutlet weak var propertyTitle: UITextField!
//    @IBOutlet weak var propertyAddress: UITextField!
//    @IBOutlet weak var city: UITextField!
//    @IBOutlet weak var state: UITextField!
//    @IBOutlet weak var zip: UITextField!
//    @IBOutlet weak var propertyImage: PFImageView!
//    
//    @IBOutlet weak var tenantUserImage: PFImageView!
//    
//    @IBOutlet weak var tenantCodeField: UITextField!
    
    @IBAction func updateTenantCodeAction(sender: AnyObject) {
        if let updateCode = currentObject as PFObject? {
            updateCode["tenantCode"] = tenantCodeField.text
            updateCode.saveInBackground()
        }
    }
    
    var currentTenant : PFUser?
    
    
    // The save button
//    @IBAction func saveButton(sender: AnyObject) {
//        
//        if let updateObject = currentObject as PFObject? {
//            
//            // Update the existing parse object
//            updateObject["title"] = propertyTitle.text
//            updateObject["address"] = propertyAddress.text
//            updateObject["city"] = city.text
//            updateObject["state"] = state.text
//            //updateObject["zip"] = zip.text
//            
//            // Save the data back to the server in a background task
//            updateObject.saveEventually()
//        } else {
//            
//            // Create a new parse object
//            var updateObject = PFObject(className:"Property")
//            
//            updateObject["title"] = propertyTitle.text
//            updateObject["address"] = propertyAddress.text
//            updateObject["city"] = city.text
//            updateObject["state"] = state.text
//            updateObject["zip"] = zip.text
//            updateObject.ACL = PFACL(user: PFUser.currentUser()!)
//            
//            // Save the data back to the server in a background task
//            updateObject.saveEventually()
//        }
//        
//        // Return to table view
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.propertyTitleField.placeholder = "+ Title" as String
        self.propertyAddressField.placeholder = "+ Address" as String
        self.propertyCityField.placeholder = "+ City" as String
        self.propertyStateField.placeholder = "CA" as String
        self.propertyZipcodeField.placeholder = "Zipcode" as String
        self.tenantCodeField.placeholder = "+ Code" as String
        
        // Unwrap the current object
        
        if let object = currentObject {
            
            if let title = object["title"] as? String {
                if (title != "") {
                    self.propertyTitleField.placeholder = title
                }
            }
            if let address = object["address"] as? String {
                if (address != "") {
                    self.propertyAddressField.placeholder = address
                }
            }
            if let city = object["city"] as? String {
                if (city != "") {
                    self.propertyCityField.placeholder = city
                }
            }
            if let state = object["state"] as? String {
                if (state != "") {
                    self.propertyStateField.placeholder = state
                }
            }
            if let zipcode = object["zip"] as? String {
                if (zipcode != "") {
                    self.propertyZipcodeField.placeholder = zipcode
                }
            }
            if let tenantCode = object["tenantCode"] as? String {
                if (tenantCode != "") {
                    self.tenantCodeField.placeholder = tenantCode
                }
            }
            
            //self.propertyTitleField.placeholder = object["title"] as? String
            //self.propertyAddressField.placeholder = object["address"] as? String
            //self.propertyCityField.placeholder = object["city"] as? String
            //self.propertyStateField.placeholder = object["state"] as? String
            //self.propertyZipcodeField.placeholder = object["zip"] as? String
            self.currentTenant = object["currentTenant"] as? PFUser
            self.tenantName.text = currentTenant?.username
            //self.tenantCodeField.placeholder = object["tenantCode"] as? String
            
//            propertyTitleLabel.text = object["title"] as? String
//            self.propertyAddressLabel.text = object["address"] as? String
//            self.propertyCityLabel.text = object["city"] as? String
//            self.propertyStateLabel.text = object["state"] as? String
//            self.propertyZipLabel.text = object["zip"] as? String
//            self.currentTenant = object["currentTenant"] as? PFUser
//            self.tenantCodeField.placeholder = object["tenantCode"] as? String
//            println("current tenant test")
//            println(currentTenant)
//            
//            if let dude = object["currentTenant"] as? PFUser {
//                self.currentTenantName.text = dude.username
//                println(currentTenantName)
                /////////
                //println(currentTenant?.username)
//            }
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
            
            let initialPropertyThumbnail = UIImage(named: "home60")
            self.propertyImageView.image = initialPropertyThumbnail
            if let propertyThumbnail = object["image"] as? PFFile {
                self.propertyImageView.file = propertyThumbnail
                self.propertyImageView.loadInBackground()
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
//        }
        
        let initialTenantThumbnail = UIImage(named: "question")
        self.tenantImageView.image = initialTenantThumbnail
        var currentTenantImage : PFFile
        if let info = currentTenant {
            if let currentTenantImage = info["image"] as? PFFile {
                self.tenantImageView.file = currentTenantImage
                self.tenantImageView.loadInBackground()
            }
        }
//        if let tenantImage = currentTenant["image"] as? PFFIle {
//            self.tenantUserImage.file = tenantImage
//            self.tenantUserImage.loadInBackground()
//        }
    }
}
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //Place the image in the imageview
        imageToUpload.image = image
        //self.propertyImageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}