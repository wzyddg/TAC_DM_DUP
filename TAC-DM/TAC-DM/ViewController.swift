//
//  ViewController.swift
//  TAC-DM
//
//  Created by FOWAFOLO on 15/7/24.
//  Copyright (c) 2015年 TAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var textBody: UITextView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.tintColor = UIColor(patternImage: UIImage(named: "menu icon")!)
        textBody.text = "1.   借还书本和雨伞请自觉登记一卡通号，姓名，手机号等相关信息，借还设备必须通过内部人员登记信息。\n\n 2. 借阅图书期限： 1个学期；\n 借用雨伞期限： 5天；\n 借用设备期限： 2周；\n 所有物品可续借，逾期不还我们将进行通知。\n\n"
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "background")?.drawInRect(self.view.bounds)
//        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        
//        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
}

