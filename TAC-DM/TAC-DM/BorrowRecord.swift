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
    var borrowerTele: String = ""
    var itemId: Int32 = 0
    var borrowThing: String = ""
    var borrowThingInfo: String = ""
    var borrowDate: NSDate
    var borrowNum: NSNumber = 0.0
    var returnDate: NSDate
    
    override init(){
        borrowDate = NSDate.new()
        returnDate = NSDate.new()
    }
}
