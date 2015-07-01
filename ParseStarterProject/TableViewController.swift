//
//  TableViewController.swift
//  toita
//
//  Created by minowaryohei on 2015/06/30.
//  Copyright (c) 2015年 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController, UITextViewDelegate {

    var toitaObjects : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.toitaObjects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TableViewCell

        // Configure the cell...
        
        cell.userLabel.text = self.toitaObjects[indexPath.row]["userName"] as String?
        
        let date = self.toitaObjects[indexPath.row].createdAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "M月d日 HH:mm"
        cell.dateLabel.text = dateFormatter.stringFromDate(date)
        
        cell.textView.editable = true
        cell.textView.editable = false
        cell.textView.text = self.toitaObjects[indexPath.row]["text"] as String!
        
        cell.textView.delegate = self

        return cell
    }

    override func viewWillAppear(animated: Bool) {
        let query: PFQuery = PFQuery(className: "ToitaObject")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.toitaObjects = objects as [PFObject]
            self.tableView.reloadData()
        }
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        if URL.scheme == "http" {
            let alert = UIAlertController(title: URL.host, message: "", preferredStyle:.ActionSheet)
            let ok = UIAlertAction(title: "Safariで開く", style: .Default) {
                action in
                UIApplication.sharedApplication().openURL(URL)
                return
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
