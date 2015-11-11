//
//  ViewController.swift
//  TAC-DM
//
//  Created by FOWAFOLO on 15/7/24.
//  Copyright (c) 2015年 TAC. All rights reserved.
//

import UIKit
import CoreText


var umbrellaId:String? = nil
class ViewController: UIViewController, DMDelegate,UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIButton!

    @IBOutlet weak var rulesView: DTAttributedTextView!

    var dmModel: DatabaseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.tintColor = UIColor(patternImage: UIImage(named: "menu icon")!)
        
        let filePath = NSBundle.mainBundle().pathForResource("rules", ofType: "html")
        let fileData = NSData(contentsOfFile: filePath!)
        let builderOptions = [DTDefaultFontFamily:"Helvetica",DTUseiOS6Attributes:true]
        
        let stringBuilder = DTHTMLAttributedStringBuilder(HTML: fileData, options: builderOptions, documentAttributes: nil)
        
        rulesView.attributedString = stringBuilder.generatedAttributedString()
        
        self.rulesView.delegate = self
        rulesView.backgroundColor = UIColor.clearColor()
        
        
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
        dmModel.getDeviceList("umbrella")
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background-bright")?.drawInRect(self.view.bounds)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage:image)
    }
    
    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    func getRequiredInfo(Info: String) {
        print("Umbrella List:\(Info)")
        
        let umbrellaDetail = Info.componentsSeparatedByString(",")
        umbrellaId = umbrellaDetail[0]
    }
}

