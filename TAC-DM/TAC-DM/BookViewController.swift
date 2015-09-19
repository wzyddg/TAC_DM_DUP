//
//  BookViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/18/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class BookViewController:UITableViewController {

// MARK:- Test Data
    let testArray = ["《懵逼设计师的自我修养》","《懵的境界》","《懵逼与设计》","《三懵逼》",  "《2015我想和懵逼谈谈》"]
 
// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        self.navigationController?.navigationBarHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // this api mush better than what i am use before remember it.
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "book background"))
    }
    func configureNavBar()
    {
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "book background")!)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.whiteColor(),NSFontAttributeName:UIFont(name: "Hiragino Kaku Gothic ProN", size: 36)!]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) 
        let row = indexPath.row
        if  0 == row % 2
        {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65)
            cell.textLabel?.text = testArray[row/2]
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else
        {
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if 0 == indexPath.row % 2
        {
            return 75
        }
        else
        {
            return 5
        }
    }
// MARK:-  UITableViewDelegate Methods 
// TODO: should return count *2 Here attention
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count * 2
    }
 
    @IBAction func backButton(sender: UIBarButtonItem) {
  //      self.navigationController?.navigationBarHidden = true
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "showDetial" {
            if let destinationVC = segue.destinationViewController as? BookDetail
            {
                destinationVC.bookName = testArray[selectedIndex!.row/2]
            }
        }
    }
}
