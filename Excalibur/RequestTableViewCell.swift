//
//  RequestTableViewCell.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/19/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class RequestTableViewCell: PFTableViewCell {

    @IBOutlet weak var requestTitle: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var requestImage: PFImageView!
    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!

}
