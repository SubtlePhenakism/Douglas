//
//  SettingsViewController.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/10/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

protocol PhotoPickersDelegate
{
    func selectPhoto(var image : UIImage)
}

class SettingsViewController: UIViewController, PhotoPickersDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var unitCount: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func uploadUserImage(sender: AnyObject) {
//        //Open a UIImagePickerController to select the picture
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIPickerViewDataSource.
//        presentViewController(imagePicker, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nc :UINavigationController = storyboard.instantiateViewControllerWithIdentifier("PhotoNC") as! UINavigationController
//        var array:NSArray = nc.viewControllers as NSArray
//        let vc:PhotoPickersVC=array.objectAtIndex(0) as! PhotoPickersVC;
//        vc.delegate=self;
//        self.presentViewController(nc, animated: true, completion: nil)
    }
    
    func selectPhoto(image: UIImage)
    {
        userImage.image=image;
    }
    
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    @IBOutlet weak var imageToUpload: UIImageView!
    //@IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var username: String?
    
    var profileImage : UIImage?
    
    @IBOutlet weak var profileImageView: PFImageView!
    
    
    
    // MARK: - Actions
    
//    @IBAction func savePressed(sender: AnyObject) {
//        
//        //Disable the save button until we are ready
//        navigationItem.rightBarButtonItem?.enabled = false
//        
//        loadingSpinner.startAnimating()
//        
//        //TODO: Upload a new picture
//        let pictureData = UIImagePNGRepresentation(imageToUpload.image)
//        
//        //Upload a new picture
//        //1
//        let file = PFFile(name: "image", data: pictureData)
//        file.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
//            if succeeded {
//                //2
//                self.saveUserInfo(file)
//            } else if let error = error {
//                //3
//                self.showErrorView(error)
//            }
//            }, progressBlock: { percent in
//                //4
//                println("Uploaded: \(percent)%")
//        })
//    }
    
//    func saveUserInfo(file: PFFile)
//    {
//        //1
//        let userInfo = ContactInfo(image: file, user: PFUser.currentUser()!)
//        //2
//        userInfo.saveInBackgroundWithBlock{ succeeded, error in
//            if succeeded {
//                //3
//                self.navigationController?.popViewControllerAnimated(true)
//            } else {
//                //4
//                if let errorMessage = error?.userInfo?["error"] as? String {
//                    self.showErrorView(error!)
//                }
//            }
//        }
//    }
    
    override func viewDidAppear(animated: Bool) {
        if let currentUserImage = PFUser.currentUser()?["image"] as? PFFile {
            self.profileImageView.file = currentUserImage
            self.profileImageView.loadInBackground()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let currentUserImage = PFUser.currentUser()?["image"] as? PFFile {
//            self.profileImageView.file = currentUserImage
//            self.profileImageView.loadInBackground()
//        }
        
        if (profileImage == nil){
            println("test1")
//            var initialThumbnail = UIImage(named: "question")
//            self.profileImageView.image = initialThumbnail
            println(profileImage)
        } else {
            println("TestImage")
            self.profileImageView.image = profileImage
            if let currentUserProfile = PFUser.currentUser() {
                println("user check")
                //currentUserProfile["image"] = profileImage
                let pictureData = UIImagePNGRepresentation(profileImage)
                
                //Upload a new picture
                //1
                let file = PFFile(name: "image", data: pictureData)
                file.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                    if succeeded {
                        //2
                        self.saveUserImage(file)
                        println("succeeded")
                    } else if let error = error {
                        //3
                        self.showErrorView(error)
                    }
                    }, progressBlock: { percent in
                        //4
                        println("Uploaded: \(percent)%")
                })
                
            }
        }
        
        
        
        //var property : PFObject?
        //println(property)
        //let propertyList = property!.objectForKey("owner") as? NSArray
        
        //var userProperties =
        
        var propertyArrary: [PFObject] = []
        var loggedInUserId : PFUser
        
        //var property : PFObject?
        if let loggedInUser = PFUser.currentUser() {
            self.usernameLabel.text = loggedInUser.username
            loggedInUserId = loggedInUser
            
            var propQuery = PFQuery(className: "Property")
            propQuery.whereKey("owner", equalTo: loggedInUserId)
            propQuery.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                if error == nil && objects != nil {
                    if let objects = objects as? [PFObject] {
                        propertyArrary = objects
                        println("Successfully retrieved",(objects.count),"objects.")
                        self.unitCount.text = String(objects.count)
                    } }
            })
            
            println(loggedInUserId)
        }
        
        
        
        
        
        
        
        
        
        
        
            
//            println(user)
//            var userId = user.objectId as String?
//            var propQuery = PFQuery(className: "Property")
//            propQuery.includeKey("owner")
//            propQuery.whereKey("owner", equalTo: user)
//            propQuery.countObjectsInBackground()
//            var propertyList = propQuery.countObjectsInBackground()
//            var cheese = propQuery.findObjectsInBackground()
//            println(userId)
//            println(user)
//            println(cheese)
            //println(propertyList)
        

        // Do any additional setup after loading the view.
    }
    
    func saveUserImage(file: PFFile)
    {
        var userInfo : PFUser
        var userImage : PFFile
        
        if let userInfo = PFUser.currentUser() {
            let profileImageData = UIImagePNGRepresentation(profileImage)
            let profileImageFile : PFFile = PFFile(data: profileImageData)
            userInfo["image"] = profileImageFile
            userInfo.saveInBackground()
            
        }
        
        //1
//        if let userInfo = PFUser.currentUser()?["image"] as? PFFile {
//            println(userInfo)
//            // My ToDO: Fix this save function!!!!!
//        } else {
//            println("didnt work")
//        }
        
        //2
//        userInfo.saveInBackgroundWithBlock{ succeeded, error in
//            if succeeded {
//                //3
//                self.navigationController?.popViewControllerAnimated(true)
//            } else {
//                //4
//                if let errorMessage = error?.userInfo?["error"] as? String {
//                    self.showErrorView(error!)
//                }
//            }
//        }
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

//extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//        //Place the image in the imageview
//        imageToUpload.image = image
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }
//}


