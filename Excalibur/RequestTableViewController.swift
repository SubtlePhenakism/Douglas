//
//  RequestTableViewController.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/19/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class RequestTableViewController: PFQueryTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureTableView()
    }
    
//    func configureTableView() {
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 75.0
//    }

    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Request"
        self.textKey = "subject"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Request")
        query.includeKey("location")
        query.includeKey("sender")
        query.orderByDescending("createdAt")
        query.whereKey("receiver", equalTo: PFUser.currentUser()!)
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("RequestCell") as! RequestTableViewCell!
        if cell == nil {
            cell = RequestTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "RequestCell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let propertyTitle = object?["location"] as? PFObject {
            cell.propertyTitle?.text = propertyTitle["address"] as? String
        }
        if let requestSender = object?["sender"] as? PFUser {
            cell.senderName.text = requestSender.username
        }
        if let requestTitle = object?["subject"] as? String {
            cell.requestTitle?.text = requestTitle
        }
        if let requestStatus = object?["status"] as? String {
            cell.requestStatus?.text = requestStatus
        }
        
        // Display flag image
        var initialThumbnail = UIImage(named: "question")
        cell?.requestImage?.image = initialThumbnail
        if let thumbnail = object?["image"] as? PFFile {
            cell.requestImage?.file = thumbnail
            cell.requestImage?.loadInBackground()
        }
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }


}