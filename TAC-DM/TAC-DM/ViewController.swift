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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.tintColor = UIColor(patternImage: UIImage(named: "menu icon")!)
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

