//
//  SettingChangeViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingChangeViewController: UIViewController, DMDelegate {
    
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var borrowLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    
    var dmModel: DMModel!
    var itemId:String?
    var itemCount:String?
    var itemLeftCount:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
        self.changeButton.layer.cornerRadius = 8.0
        
        dmModel = DMModel.getInstance()
        dmModel.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }

// MARK:- TODO : you have to update the number of the text
    func updateUI()
    {
        if let count = itemCount, leftCount = itemLeftCount {
            let borrowItemCount = Int(count)! - Int(leftCount)!
            totalLabel.text? = "总数：\(count)"
            borrowLabel.text? = "借出：\(borrowItemCount)"
            remainLabel.text? = "未借：\(leftCount)"
        }
    }
    
// MARK:- TODO : Change action don't know do what
    @IBAction func changeAction() {
        
        //where is password come from
        //如何获得newCount
        if let id = itemId {
            dmModel.editLeftNumber(id, newCount: 1000, password: "123123")
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getRequiredInfo(Info: String) {
        print("EditLeftNumber:\(Info)")
        switch Info {
        case "1":
            print("修改成功")
        case "0":
            print("修改失败")
        default:
            print("修改物品数量")
        }
    }
}
