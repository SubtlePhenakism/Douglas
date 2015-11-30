//
//  ContactTableViewCell.swift
//  Excalibur
//
//  Created by Robert Passemar on 10/20/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import Bolts

class ContactTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactStatus: UILabel!
    @IBOutlet weak var contactImage: PFImageView!
    
}
