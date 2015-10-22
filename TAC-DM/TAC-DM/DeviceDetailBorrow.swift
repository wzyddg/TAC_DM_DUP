//
//  DeviceDetailBorrow.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class DeviceDetailBorrow:UIViewController , UITextFieldDelegate , UIAlertViewDelegate, DMDelegate {
    
    var borrowDeviceName:String?
    var borrowDeviceID:String?
    var borrowDeviceDescription:String?
    var dmModel:DatabaseModel!
    
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        deviceName.text = borrowDeviceName
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    func configureUI ()
    {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "device background")?.drawInRect(self.view.bounds)
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        self.submitButton.layer.cornerRadius = 8.0
        self.nameText.delegate = self
        self.phoneText.delegate = self
    }

// MARK:- Keyboard Dismiss
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first{
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func backAction(sender: AnyObject) {
        SVProgressHUD.dismiss()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitAction() {
        
        let alertVC:UIAlertController
        //input judge with regex
        if (nameText.text!.isName() && phoneText.text!.isNumber()) {
            alertVC = UIAlertController(title: "确认信息",
                message: "姓名:  \(nameText.text!) \n 联系方式:  \(phoneText.text!) \n 所借物品:  \(borrowDeviceName!)",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealConfirmAction))
            alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        } else {
            alertVC = UIAlertController(title: "请输入正确的信息", message: nil, preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        }
        self.presentViewController(alertVC, animated: true, completion: nil)

    }
    
    func dealConfirmAction (alert:UIAlertAction!) {
        dmModel.borrowItem(nameText.text!, tele: phoneText.text!, itemId: borrowDeviceID!, itemName: borrowDeviceName!, itemDescription: borrowDeviceDescription!, number: 1)
        SVProgressHUD.show()
    }
    
    func getRequiredInfo(Info: String) {
        //设备借阅成功或者失败给出反馈
        print("借设备时得到的服务器返回值: \(Info)")
        switch Info {
        case "1":
            print("借设备成功")
            SVProgressHUD.showSuccessWithStatus("Now you can take the device with you", maskType: .Black)
            (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
        case "0":
            print("借设备失败")
            SVProgressHUD.showErrorWithStatus("Sorry,there are some troubles,please contact with TAC member", maskType: .Black)
        default:
            print("device borrow other:\(Info)")
        }
    }
}
