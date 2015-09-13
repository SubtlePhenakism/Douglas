//
//  TableViewController.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/12/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class TableViewController: PFQueryTableViewController {
    
    @IBOutlet weak var userNameLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userNameLabel.title = "@" + pUserName
        }
        
        //let propertyQuery = PFQuery(className:"Property")
        //if let user = PFUser.currentUser() {
        //    propertyQuery.whereKey("createdBy", equalTo: user)
        //}
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Property"
        self.textKey = "title"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Property")
        query.orderByAscending("title")
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("PropertyCell") as! PropertyCell!
        if cell == nil {
            cell = PropertyCell(style: UITableViewCellStyle.Default, reuseIdentifier: "PropertyCell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let title = object?["title"] as? String {
            cell?.propertyTitle?.text = title
        }
        if let address = object?["address"] as? String {
            cell?.propertyAddress?.text = address
        }
        
        // Display flag image
        var initialThumbnail = UIImage(named: "question")
        cell?.propertyImage?.image = initialThumbnail
        if let thumbnail = object?["flag"] as? PFFile {
            cell?.propertyImage?.file = thumbnail
            cell?.propertyImage?.loadInBackground()
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as! DetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = objects?[row] as? PFObject
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }
   
}
