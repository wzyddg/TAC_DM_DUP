//
//  UmbrellaViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/18/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class UmbrellaViewController: UIViewController,UIAlertViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
// MARK:- UI configure
    private func configureUI ()
    {
        submitButton.layer.cornerRadius = 8.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "umbrella background")!)
        self.nameText.delegate   = self
        self.phoneText.delegate  =  self
        self.numberText.delegate = self
    }
// MARK:- KeyBoard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
// MARK:- Button Action
    @IBAction func backButton(sender: UIButton) {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    @IBAction func submitAction() {
        let alertVC = UIAlertController(title: "确认信息",
            message: "姓名:  \(nameText.text) \n 联系方式:  \(phoneText.text) \n 所借物品:  雨伞",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealConfirmAction))
        alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
// TODO:- Override Alert Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dealConfirmAction (alert:UIAlertAction!)
    {
        println("action here")
    }
}
