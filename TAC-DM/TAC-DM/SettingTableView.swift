//
//  SettingTableView.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingTableView: UITableViewController {

// MARK:- TODO: CHANGE THE TEST DATA TO REAL
    var testData = ["懵逼iPad","懵逼iPhone","懵逼Mac","懵逼watch"]
    var isBook = true
    
// MARK:- CONFIGURE UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView (image: UIImage(named: "setting background")!)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row%2
        {
            return 75
        }
        else
        {
            return 5
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell")! as UITableViewCell
        
        if 0 == indexPath.row%2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            cell.textLabel?.text = testData[indexPath.row/2]
        }
        else
        {
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = ""
        }
        return cell
    }
   
    
// MARK:- TODO: CHANGE THE DATA TO REAL NEED TO * 2
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count * 2
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isBook
        {
            let changeViewController = storyboard!.instantiateViewControllerWithIdentifier("SettingChangeViewController") as UIViewController
            changeViewController.title = testData [indexPath.row/2]
            self.navigationController?.pushViewController(changeViewController, animated: true)
        }
        else
        {
            let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("SettingDeviceDetail") as! UITableViewController
            detailViewController.title = testData [indexPath.row/2]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

//MARK:- IF YOU WANT TO PASS DATA , CHANGE THE SEGUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if isBook
        {
        if segue.identifier == "addNewThing"
        {
            if let next = segue.destinationViewController as? SettingAddNewThing
            {
                next.title = "Add New Book"
                next.name = "书名:"
                next.second = "作者:"
                next.thrid = "数量:"
                next.hasfourthLabel = true
            }
        }
        }
        else
        {
            if segue.identifier == "addNewThing"
            {
                if let next = segue.destinationViewController as? SettingAddNewThing
                {
                    next.title = "Add New Device"
                    next.name = "设备名:"
                    next.second = "描述（颜色，型号等）:"
                    next.thrid = "数量:"
                    next.hasfourthLabel = false
                }
            }

        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
