//
//  SettingViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
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
    
    @IBAction func submitAction() {
        if passWord.text == "123"
        {
            println("next")
            let settingsEntryController = storyboard?.instantiateViewControllerWithIdentifier("SettingEntryScene") as! UIViewController
            self.presentViewController(settingsEntryController, animated: true, completion: nil)
        }
        else
        {
            let alertVC = UIAlertController(title: "密码错误",
                message: "您输入的密码有误！",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertVC.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
// MARK:- FIXME: BUG Here fix tomorrow
    @IBAction func backAction() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
}
