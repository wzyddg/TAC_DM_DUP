//
//  ViewController.swift
//  TAC-DM
//
//  Created by FOWAFOLO on 15/7/24.
//  Copyright (c) 2015年 TAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.menuButton
        {
            button.tintColor = UIColor(patternImage: UIImage(named:"menu icon")!)
        }
    }
    
    @IBOutlet var menuButton: [UIButton]!
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
}

