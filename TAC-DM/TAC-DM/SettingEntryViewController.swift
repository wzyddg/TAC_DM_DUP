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
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "setting background")?.drawInRect(self.view.bounds)
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        for  button:UIButton in typeButtons {
            button.layer.cornerRadius = button.frame.height/2
        }
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier {
            case "toSettingChangeVC":
                if let nextVC = segue.destinationViewController as? SettingChangeViewController {
                    
                    
                    nextVC.title = "Setting Umbrella"
                    nextVC.itemId = umbrellaId
                }
            case "bookSettingTableVC":
                if let nextVC = segue.destinationViewController as? SettingTableView {
                    nextVC.title = "Setting Book"
                    nextVC.isBook = true
                }
            case "deviceSettingTableVC":
                if let nextVC = segue.destinationViewController as? SettingTableView {
                    nextVC.title = "Setting Device"
                    nextVC.isBook = false
                }
            default:
                print("others")
            }
        }
        
    }
}
