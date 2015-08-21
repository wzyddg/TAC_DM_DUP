//
//  SettingEntryViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingEntryViewController: UIViewController {
   
    
    @IBOutlet var typeButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
        for  button:UIButton in typeButtons {
            button.layer.cornerRadius = button.frame.height/2
        }
    }
    
    @IBAction func umbAction() {
    }
    
    
    
    
    @IBAction func backAction() {
        let settingVC = storyboard?.instantiateViewControllerWithIdentifier("SettingVC") as! UIViewController
        self.presentViewController(settingVC, animated: true, completion: nil)
    }
    
    
}
