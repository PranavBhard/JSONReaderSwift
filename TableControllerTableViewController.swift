//
//  TableControllerTableViewController.swift
//  JSONreader
//
//  Created by Pranav Bhardwaj on 10/8/16.
//  Copyright © 2016 Pranav. All rights reserved.
//

import UIKit

class TableControllerTableViewController: UITableViewController {
    
    //data array
    var TableData:Array<String> = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromUrl("http://coursesat.tech/fall2016/CS/3510")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableCell
        cell.classData.text = TableData[indexPath.row]
        return cell
    }
 
    func getDataFromUrl(dataURL:String) {
        let data = NSData(contentsOfURL: NSURL(string: dataURL)!)
        print(data)
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            print(object);
            if let dictionary = object as? [String: AnyObject] {
                print(dictionary)
                readJSONObject(dictionary)
            }
        } catch {
            //handle error
        }
    }
    

    func readJSONObject(object: [String: AnyObject]) {
        guard let attributes = object["course_attributes"] as? String,
        let identifier = object["identifier"] as? String,
        let sections = object["sections"] as? [[String: AnyObject]] else {return}
        _ = "Class attributes " + attributes
                
        for section: [String: AnyObject] in sections {
            print("CRN:")
            print(section["crn"])
            guard let crn = section["crn"],
                let instructors = section["instructors"] else {break}
            TableData.append(identifier + "-" + (crn as! String))
        }
        for data: String in TableData {
            print("Data: " + data);
        }
        
        doTableRefresh()
        
    }
    
    func doTableRefresh () {
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            return
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
