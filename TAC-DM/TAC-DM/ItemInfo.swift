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

struct HistoryRecord {
    var historyId:String
    var borrowerName:String
    var borrowerPhone:String
    var borrowItemId:String
    var borrowItemName:String
    var borrowItemInfo:String
    var borrowTime:String
    var returnTime:String
    var borrowNumber:String
    
    init(historyId:String, borrowerName:String, borrowerPhone:String, borrowItemId:String, borrowItemName:String, borrowItemInfo:String, borrowTime:String, returnTime:String, borrowNumber:String) {
        self.historyId = historyId
        self.borrowerName = borrowerName
        self.borrowerPhone = borrowerPhone
        self.borrowItemId = borrowItemId
        self.borrowItemName = borrowItemName
        self.borrowItemInfo = borrowItemInfo
        self.borrowTime = borrowTime
        self.returnTime = returnTime
        self.borrowNumber = borrowNumber
    }
}


//judge input text
extension String {
    func isNumber() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[1-9]+[0-9]*",
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isName() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[^\\s,./<>?;':]+",
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
}