//
//  SettingDeviceDetailTableViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingDeviceDetailTableViewController: UITableViewController, DMDelegate {

    var dmModel: DMModel!
    var deviceType = ""
    var deviceNameList:[String] = []

// MARK:- CONFIGURE UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView (image: UIImage(named: "setting background")!)
        
        dmModel = DMModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deviceNameList = []
        
        dmModel.getDeviceList(deviceType)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row%2 {
            return 75
        } else {
            return 5
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceNameList.count * 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deviceCell")! as UITableViewCell
        
        if 0 == indexPath.row%2 {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            cell.textLabel?.text = deviceNameList[indexPath.row/2]
        } else {
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextVC = storyboard!.instantiateViewControllerWithIdentifier("SettingChangeViewController") as UIViewController
        nextVC.title = deviceNameList[indexPath.row/2]
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getRequiredInfo(Info: String) {
        print("DeviceList:\(Info)")
        
        let devices = Info.componentsSeparatedByString("|")
        for device in devices {
            let deviceInfo = device.componentsSeparatedByString(",")
            deviceNameList.append(deviceInfo[1])
        }
        
        self.tableView.reloadData()
    }
}
