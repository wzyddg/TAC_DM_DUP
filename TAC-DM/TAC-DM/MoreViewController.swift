//
//  MoreViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController ,UITextFieldDelegate,UIAlertViewDelegate{

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var deviceName: UITextField!
    @IBOutlet weak var deviceDescri: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
 
// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        deviceDescri.delegate = self
        deviceName.delegate =   self
        nameText.delegate =     self
        phoneText.delegate =    self
    }
    
    func configureUI ()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "more background")!)
        submitButton.layer.cornerRadius = 8.0
    }
    
// MARK:- KeyBoard Dismiss
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
// MARK:- ButtonAction
    @IBAction func backButtonAction() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    @IBAction func submitAction() {
        let alertVC = UIAlertController(title: "确认信息",
            message: "姓名:  \(nameText.text) \n 联系方式:  \(phoneText.text) \n 所借物品:  \(deviceName.text)",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealWithSubmit))
        alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
// MARK:-TODO: Here
    func dealWithSubmit(alert:UIAlertAction!)
    {
        println("action here")
    }
    
}