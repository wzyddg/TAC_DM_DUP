//
//  ItemInfo.swift
//  TAC-DM
//
//  Created by Shepard Wang on 15/8/27.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import Foundation

struct BorrowItem {
    var id:String
    var name:String
    var description:String
    var type:String
    var count:String
    var leftCount:String
    
    init(id:String, name:String, descri:String, type:String, count:String, leftCount:String) {
        self.id = id
        self.name = name
        self.description = descri
        self.type = type
        self.count = count
        self.leftCount = leftCount
    }
}