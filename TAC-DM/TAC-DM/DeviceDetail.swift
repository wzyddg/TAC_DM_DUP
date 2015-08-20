//
//  DeviceDetail.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class DeviceDetail: UITableViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var testArray = ["懵逼的iPad-white","懵逼的iPad-black","懵逼的iPad-懵逼土豪金"]

    var deviceName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.title = deviceName
        self.tableView.backgroundView = UIImageView (image: UIImage(named: "device background"))
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell") as! UITableViewCell
        
        if 0 == indexPath.row % 2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.textLabel?.text = testArray[indexPath.row/2 ]
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count * 2;
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "deviceDetailBorrow"
        {
            if let destinationVC = segue.destinationViewController as? DeviceDetailBorrow
           {
                destinationVC.borrowDeviceName = testArray[selectedIndex!.row/2]
           }
        }
    }


}
