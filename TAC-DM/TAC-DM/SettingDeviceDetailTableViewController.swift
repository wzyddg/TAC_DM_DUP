//
//  SettingDeviceDetailTableViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingDeviceDetailTableViewController: UITableViewController, DMDelegate {

    var dmModel: DatabaseModel!
    var deviceType = ""
    var devicesList:[BorrowItem] = []

    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var navTitle: UILabel!
// MARK:- CONFIGURE UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView (image: UIImage(named: "setting background")!)
        
        self.navView.backgroundColor = UIColor.clearColor()
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navTitle.text = deviceType
        
        updateUI()
        SVProgressHUD.show()
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    //更新设备列表
    func updateUI() {
        devicesList = []
        
        dmModel.getDeviceListAsAdmin(deviceType)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row%2 {
            return 75
        } else {
            return 5
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesList.count * 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deviceCell")! as UITableViewCell
        
        if 0 == indexPath.row%2 {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            cell.textLabel?.text = devicesList[indexPath.row/2].name
        } else {
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let nextVC = storyboard!.instantiateViewControllerWithIdentifier("SettingChangeViewController") as! SettingChangeViewController
        nextVC.title = devicesList[indexPath.row/2].name
        nextVC.itemId = devicesList[indexPath.row/2].id
        nextVC.itemCount = devicesList[indexPath.row/2].count
        nextVC.itemLeftCount = devicesList[indexPath.row/2].leftCount
                
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func getRequiredInfo(Info: String) {
        print("DeviceList:\(Info)")
        
        let devices = Info.componentsSeparatedByString("|")
        for device in devices {
            let deviceInfo = device.componentsSeparatedByString(",")
            
            if deviceInfo.count > 1 {
                
                let oneDevice = BorrowItem(id: deviceInfo[0], name: deviceInfo[1], descri: deviceInfo[2], type: deviceInfo[3], count: deviceInfo[4], leftCount: deviceInfo[5])
                
                devicesList.append(oneDevice)
            } else {
                print("there is no device")
            }
        }
        
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}
