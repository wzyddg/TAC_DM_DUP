//
//  SettingEntryViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

// MARK:- NO NEED TO CHAGNE THIS CONTROLLER

class SettingEntryViewController: UIViewController, DMDelegate {
   
    
    @IBOutlet var typeButtons: [UIButton]!

    var dmModel:DatabaseModel!
    var umbrellaInfo:BorrowItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        SVProgressHUD.show()
    }
    
    //更新雨伞的借出情况
    func updateUI() {
        if let id = umbrellaId {
            dmModel.getDevice(id)
        } else {
            print("unget umbrella id")
            SVProgressHUD.showErrorWithStatus("无法获得雨伞信息，请后退刷新界面")
        }
    }

    func configureUI()
    {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "setting background")?.drawInRect(self.view.bounds)
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        for  button:UIButton in typeButtons {
            button.layer.cornerRadius = button.frame.height/2
        }
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSettingChangeVC" {
            if let nextVC = segue.destinationViewController as? SettingChangeViewController {
                
                if let umbrella = umbrellaInfo {
                    nextVC.title = "Setting Umbrella"
                    nextVC.itemId = umbrella.id
                    nextVC.itemCount = umbrella.count
                    nextVC.itemLeftCount = umbrella.leftCount
                    
                } else {
                    nextVC.title = "无法获得雨伞信息，请后退刷新界面"
                }
            }
        }
        
        if segue.identifier == "bookSettingTableVC"
        {
            if let nextVC = segue.destinationViewController as? SettingTableView
            {
                nextVC.title = "Setting Book"
                nextVC.isBook = true
            }
        }
        
        if segue.identifier == "deviceSettingTableVC"
        {
            if let nextVC = segue.destinationViewController as? SettingTableView
            {
                nextVC.title = "Setting Device"
                nextVC.isBook = false
            }
        }
    }
    
    func getRequiredInfo(Info: String) {
        print("umbrella:\(Info)")
        
        let itemInfo = Info.componentsSeparatedByString(",")
        
        umbrellaInfo = BorrowItem(id: itemInfo[0], name: itemInfo[1], descri: itemInfo[2], type: itemInfo[3], count: itemInfo[4], leftCount: itemInfo[5])
        SVProgressHUD.dismiss()
    }
}
