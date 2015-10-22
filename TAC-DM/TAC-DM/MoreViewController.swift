//
//  MoreViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController ,UITextFieldDelegate,UIAlertViewDelegate, DMDelegate{

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var deviceName: UITextField!
    @IBOutlet weak var deviceDescri: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    var dmModel:DatabaseModel!
 
// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        deviceDescri.delegate = self
        deviceName.delegate =   self
        nameText.delegate =     self
        phoneText.delegate =    self
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    func configureUI ()
    {
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        UIImage(named: "more background")?.drawInRect(self.view.bounds)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage:image)
        submitButton.layer.cornerRadius = 8.0
    }
    
// MARK:- KeyBoard Dismiss
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
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
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    @IBAction func submitAction() {
        
        let alertVC:UIAlertController
        
        if (nameText.text!.isName() && phoneText.text!.isNumber() && deviceName.text!.isName() && deviceDescri.text!.isName()) {
            alertVC = UIAlertController(title: "确认信息",
                message: "姓名:  \(nameText.text!) \n 联系方式:  \(phoneText.text!) \n 所借物品:  \(deviceName.text!)",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealWithSubmit))
            alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        } else {
            alertVC = UIAlertController(title: "请输入正确的信息", message: nil, preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        }
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
// MARK:-TODO: Here
    func dealWithSubmit(alert:UIAlertAction!)
    {
        dmModel.borrowItem(nameText.text!, tele: phoneText.text!, itemId: "", itemName: deviceName.text!, itemDescription: deviceDescri.text!, number: 1)
    }
    
    func getRequiredInfo(Info: String) {
        //借阅成功或者失败做出响应
        print("借其他物品时得到的服务器返回值: \(Info)")
        switch Info {
        case "1":
            print("借其他成功")
            SVProgressHUD.showSuccessWithStatus("Now you can take it with you")
            (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
        case "0":
            print("借其他失败")
            SVProgressHUD.showErrorWithStatus("Sorry,there are some troubles,please contact with TAC member")
        default:
            print("other borrow:\(Info)")
        }
    }
}
