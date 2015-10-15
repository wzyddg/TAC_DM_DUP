//
//  HistoryTableViewCell.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    var status:Bool!
}
