//
//  UmbrellaViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/18/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class UmbrellaViewController: UIViewController,UIAlertViewDelegate,UITextFieldDelegate,DMDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    
    var dmModel: DatabaseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        refresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "umbrella background")?.drawInRect(self.view.bounds)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.view.backgroundColor = UIColor(patternImage:image)
    }
// MARK:- UI configure
    private func configureUI ()
    {
        submitButton.layer.cornerRadius = 8.0
       
        self.nameText.delegate   = self
        self.phoneText.delegate  =  self
        self.numberText.delegate = self
    }
// MARK:- KeyBoard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
// MARK:- Button Action
    @IBAction func backButton(sender: UIButton) {
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    @IBAction func submitAction() {
        
        let alertVC:UIAlertController
        
        //input judge with regex
        if (nameText.text!.isName() && phoneText.text!.isNumber() && numberText.text!.isNumber()) {
            alertVC = UIAlertController(title: "确认信息",
                message: "姓名:  \(nameText.text!) \n 联系方式:  \(phoneText.text!) \n 所借物品:  雨伞", preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "确认信息", style: .Default, handler: dealConfirmAction))
            alertVC.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        } else {
            alertVC = UIAlertController(title: "请输入正确的信息", message: nil, preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        }
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
// TODO:- Override Alert Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dealConfirmAction (alert:UIAlertAction!) {
        
        if let id = umbrellaId {
            if let borrowNum = Int(numberText.text!) {
                dmModel.borrowItem(nameText.text!, tele: phoneText.text!, itemId: id, itemName: "Umbrella", itemDescription: "", number: borrowNum)
                refresh()
            } else {
                print("unget umbrella id")
                SVProgressHUD.showErrorWithStatus("无法获得雨伞信息，请后退刷新界面")
            }
        }
        
    }
    
    func refresh()
    {
        self.nameText.text = nil;
        self.phoneText.text = nil;
        self.numberText.text = nil;
    }
    
// MARK:- Call Back Func
    func getRequiredInfo(Info: String) {
        
        switch Info {
        case "1":
            print("借伞成功")
            SVProgressHUD.showSuccessWithStatus("Now you can take an umbrella with you", maskType: .Black)
            (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
        case "0":
            print("借伞失败")
            SVProgressHUD.showErrorWithStatus("Sorry,there are some troubles,please contact with TAC member")
        default:
            print("other:\(Info)")
        }
        
    }
}
