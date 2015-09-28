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
//    var testArray = ["懵逼的iPad-white","懵逼的iPad-black","懵逼的iPad-懵逼土豪金"]
    
    var ipadNameArray:[String] = []
    var deviceName = ""
    var dmModel: DMModel!
    var ipadList:[String]?
    
//MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.title = deviceName
        self.tableView.backgroundView = UIImageView (image: UIImage(named: "device background"))
        
        dmModel = DMModel.getInstance()
        dmModel.delegate = self
//        switch deviceName {
//        case "iPad":
//            print("iPad")
//            dmModel.getDeviceList("apple_ipad")
//        case "iPhone":
//            print("iPhone")
//            dmModel.getDeviceList("apple_iphone")
//        case "Mac":
//            print("Mac")
////            dmModel.getDeviceList(")
//        default:
//            print("")
//        }
        dmModel.getDeviceList("apple_ipad")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell")! as UITableViewCell
        
        if 0 == indexPath.row % 2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            // TODO: ADD REAL DATA
//            cell.textLabel?.text = testArray[indexPath.row/2 ]
            cell.textLabel?.text = ipadNameArray[indexPath.row/2]
            // ----END----
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else
        {
            cell.textLabel?.text = ""
            cell.backgroundColor = UIColor.clearColor()
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row % 2
        {
            return 75
        }
        else
        {
            return 5
        }
    }

//MARK:-TODO: ADD DATA *2 ATTENTION
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return testArray.count * 2
        return ipadNameArray.count*2
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "deviceDetailBorrow"
        {
            if let destinationVC = segue.destinationViewController as? DeviceDetailBorrow {
//                destinationVC.borrowDeviceName = testArray[selectedIndex!.row/2]
//                destinationVC.borrowDeviceName = ipadNameArray[selectedIndex!.row/2]
                let borrowDevice = ipadList![selectedIndex!.row/2].componentsSeparatedByString(",")
                destinationVC.borrowDeviceID = borrowDevice[0]
                destinationVC.borrowDeviceName = borrowDevice[1]
                destinationVC.borrowDeviceDescription = borrowDevice[2]
           }
        }
    }

    func getRequiredInfo(Info: String) {
        print("DeviceList返回值:\(Info)")
        ipadList = Info.componentsSeparatedByString("|")
        print("数量\(ipadList!.count)")
        
        for ipad in ipadList! {
            print("ipad:\(ipad)")
            let ipadName = ipad.componentsSeparatedByString(",")
            ipadNameArray.append(ipadName[1])
        }
        
        self.tableView.reloadData()
    }
}
