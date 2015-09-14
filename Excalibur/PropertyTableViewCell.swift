//
//  PropertyTableViewCell.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/13/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import Bolts

class PropertyTableViewCell: PFTableViewCell {

    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var propertyImage: PFImageView!

}
