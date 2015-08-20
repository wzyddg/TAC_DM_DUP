//
//  DeviceDetailBorrow.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class DeviceDetailBorrow:UIViewController , UITextFieldDelegate , UIAlertViewDelegate {
    
    var borrowDeviceName = ""
    
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        deviceName.text = borrowDeviceName
    }
    
    func configureUI ()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "device background")!)
        self.submitButton.layer.cornerRadius = 8.0
        self.nameText.delegate = self
        self.phoneText.delegate = self
    }

// MARK:- Keyboard Dismiss
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

    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitAction() {
        let alertVC = UIAlertController(title: "确认信息",
            message: "姓名:  \(nameText.text) \n 联系方式:  \(phoneText.text) \n 所借物品:  \(borrowDeviceName)",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealConfirmAction))
        alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertVC, animated: true, completion: nil)

    }
    
// MARK:- TODO: Here
    func dealConfirmAction (alert:UIAlertAction!)
    {
        println("action here")
    }
}
