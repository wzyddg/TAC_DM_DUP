//
//  BookViewController.swift
//  TAC-DM
//
//  Created by Harold Liu on 8/18/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//

import UIKit

class BookViewController:UITableViewController, DMDelegate {

    var dmModel: DatabaseModel!
    var bookList:[String]? = nil
    var bookNameArray:[String] = []
//MARK:- Custom Nav 
    
    @IBOutlet weak var navView: UIView!
    @IBAction func back() {
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    
// MARK:- Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        self.navigationController?.navigationBarHidden = true
        //self.navView.backgroundColor = UIColor(patternImage:UIImage(named: "book background")!)
        self.navView.backgroundColor = UIColor.clearColor()
        dmModel = DatabaseModel.getInstance()
        dmModel.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        updateUI()
        tableView.reloadData()
        SVProgressHUD.show()
    }
    
    
    
    func refresh() {
        SVProgressHUD.show()
        updateUI()
        print("data is refresh")
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    //更新所有书籍
    func updateUI() {
        bookList = nil
        bookNameArray = []
        
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
            [NSForegroundColorAttributeName : UIColor.whiteColor(),NSFontAttributeName:UIFont(name: "Hiragino Kaku Gothic ProN", size: 30)!]
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
        SVProgressHUD.dismiss()
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        if segue.identifier == "showDetial" {
            if let destinationVC = segue.destinationViewController as? BookDetail
            {
                let book = bookList![selectedIndex!.row/2].componentsSeparatedByString(",")
                destinationVC.borrowBookId = book[0]
                destinationVC.borrowBookName = book[1]
                destinationVC.borrowBookDescription = book[2]
            }
        }
    }
    
    func getRequiredInfo(Info: String) {
        //put book list in tableView
        print("图书列表:\(Info)")
        
        bookList = Info.componentsSeparatedByString("|")
        
        for book in bookList! {
            let bookName = book.componentsSeparatedByString(",")

            //check Info is empty
            if bookName.count > 1 {
                let tmpName = "\(bookName[0]),\(bookName[1])"
                bookNameArray.append(tmpName)
            } else {
                print("there is no book")
                tableView.reloadData()
                //tableView为空，给用户提示
                SVProgressHUD.showErrorWithStatus("Sorry,there is no book for borrowing")
                return
            }
        }
        
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}
