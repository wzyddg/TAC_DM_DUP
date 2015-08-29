//
//  BorrowRecord.swift
//  TAC-DM
//
//  Created by Shepard Wang on 15/8/27.
//  Copyright (c) 2015年 TAC. All rights reserved.
//

import UIKit
import Foundation

class BorrowRecord: NSObject {
    
    var borrowerName: String = ""
    var tele: String = ""
    var itemId: Int = 0
    var itemName: String = ""
    var itemInfo: String = ""
    var borrowDate: NSDate
    var returnDate: NSDate
    var number: Int = 0
    
    override init(){
        borrowDate = NSDate.new()
        returnDate = NSDate.new()
    }
}
