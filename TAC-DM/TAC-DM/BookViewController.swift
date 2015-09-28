//
//  BookViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/18/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class BookViewController:UITableViewController, DMDelegate {

    var dmModel: DMModel!    
    var bookList:[String]?
    var bookNameArray:[String] = []
 
// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        self.navigationController?.navigationBarHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        dmModel = DMModel.getInstance()
        dmModel.delegate = self
        
        //向数据库发送得到所有书籍的请求
        dmModel.getDeviceList("book")
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
            cell.textLabel?.text = bookNameArray[row/2]
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
        return bookNameArray.count * 2
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
//                destinationVC.bookName = bookNameArray[selectedIndex!.row/2]
                let book = bookList![selectedIndex!.row/2].componentsSeparatedByString(",")
                destinationVC.borrowBookId = book[0]
                destinationVC.borrowBookName = book[1]
                destinationVC.borrowBookDescription = book[2]
            }
        }
    }
    
    //请求图书列表
    func getRequiredInfo(Info: String) {
        //将图书列表放入tableView
        print("图书列表:\(Info)")
        
        bookList = Info.componentsSeparatedByString("|")
        
        for book in bookList! {
            let bookName = book.componentsSeparatedByString(",")
            bookNameArray.append(bookName[1])
        }
        
        self.tableView.reloadData()
    }
}
