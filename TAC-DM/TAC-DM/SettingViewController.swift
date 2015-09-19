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
        configureUI()
    }
    
    func configureUI ()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
        submitButton.layer.cornerRadius = 8.0
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "setting background")!)
        self.navigationController?.navigationBar.titleTextAttributes =
         [NSForegroundColorAttributeName : UIColor.brownColor(),
            NSFontAttributeName : UIFont (name: "Hiragino Kaku Gothic ProN", size: 36)!]
    }
    
// MARK:- KeyBoard Dismiss
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitAction() {
       // MARK:- TODO: Change password
        if passWord.text == "123"
        {
            let settingsEntryController = storyboard!.instantiateViewControllerWithIdentifier("SettingEntryScene")
            self.navigationController?.pushViewController(settingsEntryController, animated: true)
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

    @IBAction func back(sender: AnyObject) {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
        
    }
}
