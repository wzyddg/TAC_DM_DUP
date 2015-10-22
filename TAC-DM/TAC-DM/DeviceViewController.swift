//
//  DeviceViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class DeviceViewController: UITableViewController, DMDelegate {

    //    var testArray = ["iPad","Mac","Apple watch","iPhone","iPod"]
    var dmModel:DatabaseModel!
    var deviceTypeList:[String] = []

    @IBAction func back() {
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    @IBOutlet weak var navView: UIView!
// MARK:- Custom Nav

// MARK:-Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navView.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBarHidden = true
        updateUI()
        SVProgressHUD.show()
    }
    
    func refresh() {
        SVProgressHUD.show()
        updateUI()
        print("data is refresh")
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    //更新所有设备种类列表
    func updateUI() {
        deviceTypeList = []
        
        dmModel.getDeviceType()
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
             NSFontAttributeName : UIFont(name: "Hiragino Kaku Gothic ProN", size: 30)!]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeviceCell")! as UITableViewCell
        
        if 0 == indexPath.row % 2 {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            // TODO: ADD DATA
            cell.textLabel?.text = deviceTypeList[indexPath.row/2 ]
            // -----end----
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
        return deviceTypeList.count * 2;
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
//        self.navigationController?.navigationBarHidden = true
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "showDeviceDetail"
        {
            if let destinationVC = segue.destinationViewController as? DeviceDetail
            {
                destinationVC.deviceName = deviceTypeList[selectedIndex!.row/2]
            }
        }
    }
    
    func getRequiredInfo(Info: String) {
        print("设备种类:\(Info)")
        
        let typeList = Info.componentsSeparatedByString("|")
        for type in typeList {
            if type.hasPrefix("apple_") {
                deviceTypeList.append(type)
            }
        }
        
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
}
