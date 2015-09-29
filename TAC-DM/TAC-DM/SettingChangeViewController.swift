//
//  SettingChangeViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/23/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class SettingChangeViewController: UIViewController, DMDelegate {
    
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var borrowLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    
    var dmModel: DMModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "setting background")!)
        self.changeButton.layer.cornerRadius = 8.0
        
        dmModel = DMModel.getInstance()
        dmModel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }

// MARK:- TODO : you have to update the number of the text
    func updateUI()
    {
        //update the text data here
    }
    
// MARK:- TODO : Change action don't know do what
    @IBAction func changeAction() {
        
        //where is password come from
        dmModel.editLeftNumber("itemID", newCount: 1, password: "password")
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getRequiredInfo(Info: String) {
        print("EditLeftNumber:\(Info)")
    }
}
