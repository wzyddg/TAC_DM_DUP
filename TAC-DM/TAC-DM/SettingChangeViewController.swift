//
//  SettingChangeViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.

import UIKit

class SettingChangeViewController: UIViewController, DMDelegate {
    
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var borrowLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    
    var dmModel: DatabaseModel!
    var itemId:String?
    var itemCount:String?
    var itemLeftCount:String?
    var newItemLeftCount:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeButton.layer.cornerRadius = 8.0
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "setting background")?.drawInRect(self.view.bounds)
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage:image)

    }

    func updateUI() {
        if let count = itemCount, leftCount = itemLeftCount {
            print("2")
            let borrowItemCount = Int(count)! - Int(leftCount)!
            totalLabel.text = "总数：\(count)"
            borrowLabel.text = "借出：\(borrowItemCount)"
            remainLabel.text = "未借：\(leftCount)"
        }
    }
    
    //更新借出状况
    func getNewCount() {
        dmModel.getDevice("3")//为什么第二次发送消息就无法得到回调？？？？？？？？
    }
    
// MARK:- TODO : Change action don't know do what
    @IBAction func changeAction() {
        
        let alertVC = UIAlertController(title: "修改数量", message: "请输入现在的剩余数量", preferredStyle: .Alert)
        
        var numberBeChangedField:UITextField?
        alertVC.addTextFieldWithConfigurationHandler(){ (textField) in
            numberBeChangedField = textField
            numberBeChangedField?.placeholder = "Left Number"
        }
        
        alertVC.addAction(UIAlertAction(title: "确认", style: .Default, handler: { (alert:UIAlertAction) in
            let leftNum = Int(numberBeChangedField!.text!)

            if let id = self.itemId, number = leftNum {
                print("id:\(id),number:\(number)")
                SVProgressHUD.show()
                self.dmModel.editLeftNumber(id, newCount: number, password: "123123")
                self.newItemLeftCount = "\(number)"
            } else {
                print("not get itemId or number")
            }
        }))
        alertVC.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getRequiredInfo(Info: String) {
        print("EditLeftNumberInfo:\(Info)")
        switch Info {
        case "1":
            print("修改成功")
            SVProgressHUD.dismiss()
            self.itemLeftCount = newItemLeftCount
            updateUI()
        case "0":
            print("修改失败")
            SVProgressHUD.showErrorWithStatus("Sorry, there are some problems, the number of item has not been changed...")
        default:
            print("change item number other:\(Info)")
            let itemInfo = Info.componentsSeparatedByString(",")
            if itemInfo.count > 1 {
                let item = BorrowItem(id: itemInfo[0], name: itemInfo[1], descri: itemInfo[2], type: itemInfo[3], count: itemInfo[4], leftCount: itemInfo[5])
                self.itemCount = item.count
                self.itemLeftCount = item.leftCount
                updateUI()
            } else {
                print("没有得到itemInfo")
            }
        }
    }
}
