//
//  DeviceViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class DeviceViewController: UITableViewController
{
// MARK:-TODO: TEST DATA
    var testArray = ["懵逼的iPad","懵逼的Mac","懵逼的Apple watch","懵逼的iPhone","懵逼的iPod","懵逼"]
    
    
// MARK:-Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "device background"))
    }
    
    func configureUI ()
    {
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "device background")!)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.whiteColor(),
             NSFontAttributeName : UIFont(name: "Hiragino Kaku Gothic ProN", size: 36)!]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeviceCell")! as UITableViewCell
        
        if 0 == indexPath.row % 2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            // TODO: ADD DATA
            cell.textLabel?.text = testArray[indexPath.row/2 ]
            // -----end----
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
        return testArray.count * 2;
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
//        self.navigationController?.navigationBarHidden = true
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "showDeviceDetail"
        {
            if let destinationVC = segue.destinationViewController as? DeviceDetail
            {
                destinationVC.deviceName = testArray[selectedIndex!.row/2]
            }
        }
    }
    
}
