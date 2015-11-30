//
//  PropertyInfo.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/24/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class PropertyInfo: PFObject, PFSubclassing {
    
    @NSManaged var image: PFFile
    @NSManaged var user: PFUser
    @NSManaged var title: String?
    
    //1
    class func parseClassName() -> String {
        return "Property"
    }
    
    //2
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        //1
        let query = PFQuery(className: PropertyInfo.parseClassName())
        //2
        query.includeKey("user")
        query.includeKey("currentTenant.username")
        //3
        query.orderByDescending("createdAt")
        return query
    }
    
    init(image: PFFile, user: PFUser) {
        super.init()
        
        self.image = image
        self.user = user
        self.title = title as String?
    }
    
    override init() {
        super.init()
    }
   
}
