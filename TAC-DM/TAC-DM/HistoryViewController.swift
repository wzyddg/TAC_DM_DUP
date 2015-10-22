//
//  HistoryViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController,UIAlertViewDelegate, DMDelegate{

// MARK:-TODO: change the test data to real
// 建议将每条记录写成一个struct， 里面有它的属性
    var dmModel: DatabaseModel!
    var borrowRecords:[HistoryRecord] = []

// MARK:- Custom Nav
    
    @IBAction func back() {
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    @IBOutlet weak var navView: UIView!

// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        configureUI()
        self.navView.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBarHidden = true
        updateUI()
        SVProgressHUD.show()
    }
    //更新历史列表
    func updateUI() {
        borrowRecords = []
        dmModel.getRecordList()
    }
    func configureUI ()
    {
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "history background"))
        
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage:UIImage(named: "history background")!)
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.whiteColor() ,
                NSFontAttributeName :UIFont(name: "Hiragino Kaku Gothic ProN", size: 30)!]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as! HistoryTableViewCell

        if 0 == indexPath.row%2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            cell.nameLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.typeLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.timeLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
            if !borrowRecords.isEmpty {
                cell.nameLabel?.text = borrowRecords[indexPath.row/2].borrowerName
                cell.typeLabel?.text = borrowRecords[indexPath.row/2].borrowItemName
                cell.timeLabel?.text = borrowRecords[indexPath.row/2].borrowTime
                if borrowRecords[indexPath.row/2].returnTime != "0" {
                    cell.statusImg.image = UIImage(named: "checked icon")
                    cell.status = true
                } else {
                    cell.statusImg.image = UIImage(named: "unchecked icon")
                    cell.status = false
                }
            }

        } else {
            cell.backgroundColor = UIColor.clearColor()
            cell.nameLabel?.text = ""
            cell.typeLabel?.text = ""
            cell.timeLabel?.text = ""
            cell.statusImg?.image = nil

        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if 0 == indexPath.row%2 {
            return 75
        } else {
            return 5
        }
    }
//TODO:- ADD DATA *2 ATTENTION
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return borrowRecords.count * 2
    }
    
    @IBAction func backAction(sender: AnyObject) {
       // self.navigationController?.navigationBarHidden = true
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! HistoryTableViewCell
        if cell.status == false {
        
            let alert = UIAlertController(title: "确认归还？",
            message: "姓名:\(cell.nameLabel.text!) \n 电话号码: \(borrowRecords[indexPath.row/2].borrowerPhone) \n 设备: \(cell.typeLabel.text!) \n ",
            preferredStyle: UIAlertControllerStyle.Alert)
        
            alert.addAction(UIAlertAction(title: "确认",
                style: UIAlertActionStyle.Default,
                handler: {(alert: UIAlertAction) in
                    cell.statusImg.image = UIImage(named: "checked icon")
                    cell.status = true
                    self.dealWithAction(self.borrowRecords[indexPath.row/2].historyId)}))
            alert.addAction(UIAlertAction(title: "取消",
                style: UIAlertActionStyle.Cancel,
                handler: nil))
        
            self.presentViewController(alert, animated: true, completion: nil)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
// MARK:-TODO: update the status of database
    func dealWithAction(recordId:String) {        
        dmModel.returnItem(recordId)
    }
    
    func getRequiredInfo(Info: String) {
        
        
        switch Info {
        case "1":
            print("归还物品成功")
            SVProgressHUD.showSuccessWithStatus("Your borrowed thing has been return")
        case "0":
            print("归还物品失败")
            SVProgressHUD.showErrorWithStatus("Sorry,there are some troubles,please contact with TAC member")
        default:
            let borrowHistoryList = Info.componentsSeparatedByString("|")
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            
            
            for record in borrowHistoryList {
                print("RECORD:\(record)")
                
                //判断历史是否为空
                if "" == record {
                    //历史数据为空
                    break
                } else {
                    let oneRecord = record.componentsSeparatedByString(",")
                    
                    let oneHistoryRecord = HistoryRecord(historyId: oneRecord[0], borrowerName: oneRecord[1],
                        borrowerPhone: oneRecord[2], borrowItemId: oneRecord[3],
                        borrowItemName: oneRecord[4], borrowItemInfo: oneRecord[5],
                        borrowTime: getReallytime(oneRecord[6], dateFormatter: dateFormatter),
                        returnTime: oneRecord[7], borrowNumber: oneRecord[8])
                    
                    borrowRecords.append(oneHistoryRecord)
                }
            }
            
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    //时间戳转换
    func getReallytime(timeStringFrom1970Millisecond:String, dateFormatter:NSDateFormatter) -> String {
        let timeNSString:NSString = (timeStringFrom1970Millisecond as NSString).substringToIndex(10)
        let date = NSDate(timeIntervalSince1970: timeNSString.doubleValue)
        
        return dateFormatter.stringFromDate(date)
    }
}


