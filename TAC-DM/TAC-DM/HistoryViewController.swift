//
//  HistoryViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import  UIKit

class HistoryViewController: UITableViewController,UIAlertViewDelegate, DMDelegate{

// MARK:-TODO: change the test data to real
// 建议将每条记录写成一个struct， 里面有它的属性
//    var testData = ["懵逼","懵逼","懵逼"]
    var status = false
    var dmModel: DMModel!
    var borrowRecords:[String] = []

// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        dmModel = DMModel.getInstance()
        dmModel.delegate = self
        
        dmModel.getRecordList()
    }
    
    func configureUI ()
    {
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "history background"))
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage:UIImage(named: "history background")!)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.whiteColor() ,
                NSFontAttributeName :UIFont(name: "Hiragino Kaku Gothic ProN", size: 36)!]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as! HistoryTableViewCell

        if 0 == indexPath.row%2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.nameLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.typeLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.timeLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)

            if borrowRecords.count > 0 {
                let recordInfo = borrowRecords[indexPath.row/2].componentsSeparatedByString(",")
                
                //run crash
                cell.nameLabel?.text = recordInfo[1]
                cell.typeLabel?.text = recordInfo[4]
                cell.timeLabel?.text = recordInfo[6]
                if recordInfo[7] != "0" {
                    cell.statusImg.image = UIImage(named: "checked icon")
                } else {
                    cell.statusImg.image = UIImage(named: "unchecked icon")
                }
            }
        }
        else
        {
            cell.backgroundColor = UIColor.clearColor()
            cell.nameLabel?.text = ""
            cell.typeLabel?.text = ""
            cell.timeLabel?.text = ""
            cell.statusImg?.image = nil

        }
        return cell
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
//TODO:- ADD DATA *2 ATTENTION
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return borrowRecords.count * 2
    }
    
    @IBAction func backAction(sender: AnyObject) {
       // self.navigationController?.navigationBarHidden = true
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! HistoryTableViewCell
        if status == false
        {
            let recordInfo = borrowRecords[indexPath.row/2].componentsSeparatedByString(",")
        
            let alert = UIAlertController(title: "确认归还？",
            message: "姓名:\(cell.nameLabel.text!) \n 电话号码: \(recordInfo[2]) \n 设备: \(cell.typeLabel.text!) \n ",
            preferredStyle: UIAlertControllerStyle.Alert)
        
            alert.addAction(UIAlertAction(title: "确认",
                style: UIAlertActionStyle.Default,
                handler: {(alert: UIAlertAction) in cell.statusImg.image = UIImage(named: "checked icon"); self.dealWithAction(recordInfo[0])}))
            alert.addAction(UIAlertAction(title: "取消",
                style: UIAlertActionStyle.Cancel,
                handler: nil))
        
            self.presentViewController(alert, animated: true, completion: nil)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
// MARK:-TODO: update the status of database
    func dealWithAction(recordId:String) {
        status  == true
        
        dmModel.returnItem(recordId)
    }
    
    func getRequiredInfo(Info: String) {
        
        if (Info == "1" || Info == "0") {
            //归还物品成功或者失败action
            
        } else {
            borrowRecords = Info.componentsSeparatedByString("|")
            
            for record in borrowRecords {
                print("Record:\(record)")
            }
            
            self.tableView.reloadData()
        }
    }
}
