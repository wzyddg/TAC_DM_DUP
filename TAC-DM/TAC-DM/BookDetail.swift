//
//  BookDetail.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/20/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class BookDetail : UIViewController,UIAlertViewDelegate,UITextFieldDelegate,DMDelegate
{
    
    var borrowBookName = ""
    var borrowBookId:String?
    var borrowBookDescription:String?
    var dmModel:DatabaseModel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var selectedBookName: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        configureUI()
        selectedBookName.text = borrowBookName
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "book background")?.drawInRect(self.view.bounds)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func configureUI ()
    {
        self.submitButton.layer.cornerRadius = 8.0
        self.nameTextField.delegate = self
        self.phoneTextField.delegate = self
    }
    
// MARK:- Keyboard Dismiss
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first  {
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
        
        let alertVC:UIAlertController
        //empty input judge
        if (nameTextField.text!.isName() && phoneTextField.text!.isNumber()) {
            alertVC = UIAlertController(title: "确认信息",
                message: "姓名:  \(nameTextField.text!) \n 联系方式:  \(phoneTextField.text!) \n 所借物品:  \(borrowBookName)",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertVC.addAction(UIAlertAction(title: "确认信息", style: UIAlertActionStyle.Default, handler: dealConfirmAction))
            alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        } else {
            alertVC = UIAlertController(title: "请输入正确的信息", message: nil, preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        }
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        SVProgressHUD.dismiss()
        self.navigationController?.popViewControllerAnimated(true)
    }

    func dealConfirmAction (alert:UIAlertAction!) {
        SVProgressHUD.show()
        dmModel.borrowItem(nameTextField.text!, tele: phoneTextField.text!, itemId: borrowBookId!, itemName: borrowBookName, itemDescription: borrowBookDescription!, number: 1)
    }
    
    func getRequiredInfo(Info: String) {
        //得到服务器的返回值
        print("借书时得到的服务器返回值: \(Info)")
        switch Info {
        case "1":
            print("借书成功")
            SVProgressHUD.showSuccessWithStatus("Now you can take the book with you", maskType: .Black)
            backAction(self)
        case "0":
            print("借书失败")
            SVProgressHUD.showErrorWithStatus("Sorry,there are some troubles,please contact with TAC member", maskType: .Black)
        default:
            print("book borrow other:\(Info)")
        }
    }
}
