//
//  SettingAddNewThing.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingAddNewThing: UIViewController, DMDelegate {

// MARK:- DATA FROM SEGUE
    var name = ""
    var second = ""
    var thrid = ""
    var fourth = ""
    var hasfourthLabel = true
    var dmModel: DMModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thridLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var secondeDeriText: UITextField!
    @IBOutlet weak var thridDeriText: UITextField!
    @IBOutlet weak var fourthDeriText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
// MARK:- CONFIGURE UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButton.layer.cornerRadius = 8.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
        self.nameLabel.text = name
        self.secondLabel.text = second
        self.thridLabel.text = thrid
        if !hasfourthLabel {
            self.fourthLabel.text = ""
            fourthDeriText.userInteractionEnabled = false
            self.fourthDeriText.borderStyle = UITextBorderStyle.None
        }
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
// MARK:- BUTTON ACTION
    @IBAction func submitAction() {
        let alertVC = UIAlertController(title: "确认信息",
            message: "名字:  \(nameText.text) \n 信息:  \(secondeDeriText.text) \n 数量:  \(thridDeriText.text)",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealWithSubmit))
        alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
// MARK:- TODO: UPDATE THE DATA 
    func dealWithSubmit (alert:UIAlertAction!) {
        
    }
    
    func getRequiredInfo(Info: String) {
        
    }
}
