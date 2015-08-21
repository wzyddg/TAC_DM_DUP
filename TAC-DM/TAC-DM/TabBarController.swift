//
//  TabBarController.swift
//  TAC-DM
//
//  Created by FOWAFOLO on 15/7/27.
//  Copyright (c) 2015年 TAC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var sidebar: FrostedSidebar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.hidden = true
        
        moreNavigationController.navigationBar.hidden = true
        
        sidebar = FrostedSidebar(itemImages: [
            UIImage(named: "home button icon")!,
            UIImage(named: "umbrella")!,
            UIImage(named: "book")!,
            UIImage(named: "device")!,
            UIImage(named: "history")!,
            UIImage(named: "more")!,
            UIImage(named: "setting")!,
            ],
            colors: [
                UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 0.7),
                UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 0.7),
                UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 0.7),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 0.7),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 0.7),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 0.7),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 0.7),
            ],
            selectedItemIndices: NSIndexSet(index: 0))
        
        sidebar.isSingleSelect = true
        sidebar.actionForIndex = [
            0: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 0}) },
            1: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 1}) },
            2: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 2}) },
            3: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 3}) },
            4: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 4}) },
            5: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 5}) },
            6: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 6}) },
            7: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 7}) }]
    }
    
}
