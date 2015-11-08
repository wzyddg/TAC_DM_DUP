//
//  SettingTableView.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingTableView: UITableViewController, DMDelegate {

    var isBook = true
    var dmModel:DatabaseModel!
    var itemList:[BorrowItem] = []
    
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
        
        SVProgressHUD.show()
        updateUI()
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    //更新书或者设备种类列表
    func updateUI() {
        itemList = []
        
        if isBook {
            dmModel.getDeviceListAsAdmin("book")
            self.navTitle.text = "Book"
        } else {
            dmModel.getDeviceType()
            self.navTitle.text = "Devices"
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row%2 {
            return 75
        } else {
            return 5
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell")! as UITableViewCell
        
        if 0 == indexPath.row%2 {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            cell.textLabel?.text = itemList[indexPath.row/2].name
        } else {
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = ""
        }
        return cell
    }
   
    
// MARK:- TODO: CHANGE THE DATA TO REAL NEED TO * 2
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count * 2
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isBook {
            let changeViewController = storyboard!.instantiateViewControllerWithIdentifier("SettingChangeViewController") as! SettingChangeViewController
            changeViewController.title = itemList[indexPath.row/2].name
            changeViewController.itemId = itemList[indexPath.row/2].id
            changeViewController.itemCount = itemList[indexPath.row/2].count
            changeViewController.itemLeftCount = itemList[indexPath.row/2].leftCount
            self.navigationController?.pushViewController(changeViewController, animated: true)
        } else {
            let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("SettingDeviceDetail") as! SettingDeviceDetailTableViewController
            detailViewController.title = itemList [indexPath.row/2].type
            detailViewController.deviceType = itemList[indexPath.row/2].type
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

//MARK:- IF YOU WANT TO PASS DATA , CHANGE THE SEGUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if isBook {
            if segue.identifier == "addNewThing" {
                if let next = segue.destinationViewController as? SettingAddNewThing {
                    next.title = "Add New Book"
                    next.name = "书名:"
                    next.second = "描述:"
                    next.thrid = "数量:"
                    next.hasfourthLabel = false
                }
            }
        } else {
            if segue.identifier == "addNewThing" {
                if let next = segue.destinationViewController as? SettingAddNewThing {
                    next.title = "Add New Device"
                    next.name = "设备名:"
                    next.second = "描述（颜色，型号等）:"
                    next.thrid = "数量:"
                    next.hasfourthLabel = true
                }
            }
        }
    }
        
    func getRequiredInfo(Info: String) {
        print("Admin manage:\(Info)")
        
        let items = Info.componentsSeparatedByString("|")
        
        if isBook {
            for item in items {
                let itemInfo = item.componentsSeparatedByString(",")
                
                let oneItem = BorrowItem(id: itemInfo[0], name: itemInfo[1], descri: itemInfo[2], type: itemInfo[3], count: itemInfo[4], leftCount: itemInfo[5])
                
                itemList.append(oneItem)
            }
        } else {
            for item in items {
                if item.hasPrefix("apple_") {
                    let oneItem = BorrowItem(id: "", name: item, descri: "", type: item, count: "", leftCount: "")
                    itemList.append(oneItem)
                }
            }
        }
        
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}
