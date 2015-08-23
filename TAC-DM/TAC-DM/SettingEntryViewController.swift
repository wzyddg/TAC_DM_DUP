//
//  SettingEntryViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/21/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

// MARK:- NO NEED TO CHAGNE THIS CONTROLLER

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
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSettingChangeVC"
        {
            if let nextVC = segue.destinationViewController as? SettingChangeViewController
            {
                nextVC.title = "Setting Umbrella"
            }
        }
        
        if segue.identifier == "bookSettingTableVC"
        {
            if let nextVC = segue.destinationViewController as? SettingTableView
            {
                nextVC.title = "Setting Book"
                nextVC.isBook = true
            }
        }
        
        if segue.identifier == "deviceSettingTableVC"
        {
            if let nextVC = segue.destinationViewController as? SettingTableView
            {
                nextVC.title = "Setting Device"
                nextVC.isBook = false
            }
        }
        
        
    }
    
}
