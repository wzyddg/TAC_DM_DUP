//
//  BookDetail.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class BookDetail : UIViewController,UIAlertViewDelegate,UITextFieldDelegate
{
    
    var bookName = ""
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var selectedBookName: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        configureUI()
        selectedBookName.text = bookName
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "book background")!)
    }
    
    func configureUI ()
    {
       
        self.submitButton.layer.cornerRadius = 8.0
        self.nameTextField.delegate = self
        self.phoneTextField.delegate = self
    }
    
// MARK:- Keyboard Dismiss
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first  {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
// MARK:- Button Action
    @IBAction func submitAction() {
        let alertVC = UIAlertController(title: "确认信息",
            message: "姓名:  \(nameTextField.text) \n 联系方式:  \(phoneTextField.text) \n 所借物品:  \(bookName)",
            preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealConfirmAction))
        alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertVC, animated: true, completion: nil)
        
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
// MARK:- TODO: Here
    func dealConfirmAction (alert:UIAlertAction!)
    {
        print("action here")
    }
}
