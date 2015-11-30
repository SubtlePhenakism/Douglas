//
//  UploadImageViewController.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/24/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class UploadImageViewController: UIViewController {
    
    @IBOutlet weak var imageToUpload: UIImageView!
    //@IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var username: String?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func selectPicturePressed(sender: AnyObject) {
        //Open a UIImagePickerController to select the picture
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePressed(sender: AnyObject) {
        
        //Disable the save button until we are ready
        navigationItem.rightBarButtonItem?.enabled = false
        
        loadingSpinner.startAnimating()
        
        //TODO: Upload a new picture
        let pictureData = UIImagePNGRepresentation(imageToUpload.image)
        
        //Upload a new picture
        //1
        let file = PFFile(name: "image", data: pictureData)
        file.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
            if succeeded {
                //2
                self.savePropertyInfo(file)
            } else if let error = error {
                //3
                self.showErrorView(error)
            }
            }, progressBlock: { percent in
                //4
                println("Uploaded: \(percent)%")
        })
    }
    
    func savePropertyInfo(file: PFFile)
    {
        var property = PFObject(className: "Property")
        println(property)
        //1
        let propertyInfo = PropertyInfo(image: file, user: PFUser.currentUser()!)
        //2
        propertyInfo.saveInBackgroundWithBlock{ succeeded, error in
            if succeeded {
                //3
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                //4
                if let errorMessage = error?.userInfo?["error"] as? String {
                    self.showErrorView(error!)
                }
            }
        }
    }
}

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //Place the image in the imageview
        imageToUpload.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
