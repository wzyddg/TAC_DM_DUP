//
//  BorrowRecord.swift
//  TAC-DM
//
//  Created by Shepard Wang on 15/8/27.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit
import Foundation

class BorrowRecord: NSObject {
    
    var recordId: Int = 0
    var borrowerName: String = ""
    var tele: String = ""
    var itemId: Int = 0
    var itemName: String = ""
    var itemDescription: String = ""
    var borrowDate: NSDate
    var returnDate: NSDate
    var number: Int = 0
    
    override init(){
        borrowDate = NSDate()
        returnDate = NSDate()
    }
}
