//
//  SettingViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, DMDelegate {

    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var dmModel: DatabaseModel!
 
//MARK:- Custom Nav
    
    @IBAction func back() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
        
    }
    @IBOutlet weak var navView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        configureUI()
        self.navigationController?.navigationBarHidden = true
        self.navView.backgroundColor = UIColor.clearColor()
    }
    
    func configureUI ()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
        submitButton.layer.cornerRadius = 8.0
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "setting background")!)
        self.navigationController?.navigationBar.titleTextAttributes =
         [NSForegroundColorAttributeName : UIColor.brownColor(),
            NSFontAttributeName : UIFont (name: "Hiragino Kaku Gothic ProN", size: 30)!]
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
    
    @IBAction func submitAction() {
        if let pass = passWord.text {
            print("password is : \(pass)")
            dmModel.adminLogin(pass)
        } else {
            print("text is nil")
        }
    }

    @IBAction func back(sender: AnyObject) {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
        
    }
    
    func getRequiredInfo(Info: String) {

        print("Info are :\(Info)")
        
        if (Info == "1") {
            let settingsEntryController = storyboard!.instantiateViewControllerWithIdentifier("SettingEntryScene")
            self.navigationController?.pushViewController(settingsEntryController, animated: true)
        } else {
            let alertVC = UIAlertController(title: "密码错误",
                message: "您输入的密码有误！",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertVC.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertVC, animated: true, completion: nil)
        }

    }
}
