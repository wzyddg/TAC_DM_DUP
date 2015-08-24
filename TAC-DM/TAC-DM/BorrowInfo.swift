//
//  BorrowInfo.swift
//  TAC-DM
//
//  Created by 一川 on 8/24/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import Foundation
import CoreData

class BorrowInfo: NSManagedObject {

    @NSManaged var borrowerName: String
    @NSManaged var borrowerTele: String
    @NSManaged var borrowThing: String
    @NSManaged var borrowThingInfo: String
    @NSManaged var borrowDate: NSDate
    @NSManaged var borrowNum: NSNumber
    @NSManaged var returnDate: NSDate

}
