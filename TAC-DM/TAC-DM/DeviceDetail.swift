//
//  DeviceDetail.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class DeviceDetail: UITableViewController, DMDelegate {
    
//MARK:-TODO: ADD REAL DATA
    
    var devicesNameArray:[String] = []
    var deviceName = ""
    var dmModel: DatabaseModel!
    var devicesList:[String]?
    
//MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.title = deviceName
        self.tableView.backgroundView = UIImageView (image: UIImage(named: "device background"))
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    }
    
    func refresh() {
        SVProgressHUD.show()
        updateUI()
        print("data is refresh")
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        SVProgressHUD.show()
    }
    
    //更新设备列表
    func updateUI() {
        devicesNameArray = []
        devicesList = nil
        
        dmModel.getDeviceList(deviceName)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell")! as UITableViewCell
        
        if 0 == indexPath.row % 2 {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.textLabel?.text = devicesNameArray[indexPath.row/2]
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        } else {
            cell.textLabel?.text = ""
            cell.backgroundColor = UIColor.clearColor()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row % 2 {
            return 75
        } else {
            return 5
        }
    }

//MARK:-TODO: ADD DATA *2 ATTENTION
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesNameArray.count*2
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        SVProgressHUD.dismiss()
        self.navigationController?.popViewControllerAnimated(true)
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "deviceDetailBorrow"
        {
            if let destinationVC = segue.destinationViewController as? DeviceDetailBorrow {
                let borrowDevice = devicesList![selectedIndex!.row/2].componentsSeparatedByString(",")
                destinationVC.borrowDeviceID = borrowDevice[0]
                destinationVC.borrowDeviceName = borrowDevice[1]
                destinationVC.borrowDeviceDescription = borrowDevice[2]
           }
        }
    }

    func getRequiredInfo(Info: String) {
        print("DeviceList返回值:\(Info)")
        devicesList = Info.componentsSeparatedByString("|")
        
        for device in devicesList! {
            print("device:\(device)")
            let deviceInfo = device.componentsSeparatedByString(",")
            
            if deviceInfo.count > 1 {
                devicesNameArray.append(deviceInfo[1])
            } else {
                print("there is no device")
                
                //tableView为空，给用户提示
                SVProgressHUD.showErrorWithStatus("Sorry,there is no device for borrowing")
                return
            }
        }
        
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}
