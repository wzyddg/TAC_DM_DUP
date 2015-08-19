//
//  BookViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/18/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class BookViewController:UITableViewController,UITableViewDataSource,UITableViewDelegate {
   
    let textCellIdentifier = "TextCell"
    let testArray = ["《懵逼设计师的自我修养》","《懵的境界》","《懵逼与设计》","《三懵逼》",  "《2015我想和懵逼谈谈》"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "book background")!)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    func configureNavBar()
    {
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "book background")!)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.whiteColor(),NSFontAttributeName:UIFont(name: "Hiragino Kaku Gothic ProN", size: 30)!]
    }
    
    // MARK:  UITextFieldDelegate Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = testArray[row]
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println("\(testArray[row])")
    }
    
}
