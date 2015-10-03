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