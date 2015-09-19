//
//  SettingDeviceDetailTableViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingDeviceDetailTableViewController: UITableViewController {

// MARK:- TODO: TEST DATA CHAGNE TO REAL
    var testData = ["懵逼iPad","懵逼iPhone","懵逼Mac","懵逼watch"]

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
// MARK:- TODO: CHANGE TEST DATA EVERYWHERE
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count * 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deviceCell")! as UITableViewCell
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextVC = storyboard!.instantiateViewControllerWithIdentifier("SettingChangeViewController") as UIViewController
        nextVC.title = testData[indexPath.row/2]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
