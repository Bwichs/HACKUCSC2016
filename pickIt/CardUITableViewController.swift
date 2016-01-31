//
//  CardUITableViewController.swift
//  pickIt
//
//  Created by Loren Yeung on 29/4/2016.
//  Copyright © 2016 Parse. All rights reserved.
//
/*objectId, firstImage, createdAt, updatedAt, ACL, secImage, productDescription, userName */

import UIKit
import Parse
import ParseUI


class CardUITableViewController: PFQueryTableViewController {
    
    /*
        image1.image = UIImage(named: "example_image.png")
        image2.image = UIImage(named: "example_image.png")
        let tapGestureRecognizer1 = UITapGestureRecognizer(target:self, action:Selector("image1Tapped:"))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target:self, action:Selector("image2Tapped:"))
        image1.userInteractionEnabled = true
        image1.addGestureRecognizer(tapGestureRecognizer1)
        image2.userInteractionEnabled = true
        image2.addGestureRecognizer(tapGestureRecognizer2)
    */
    
    var oi : String? = ""
    var pv : Int? = 0
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as! CardUITableViewCell
        print(currentCell.objectId!.text!)
        oi = currentCell.objectId!.text
        
    }
    
    func image1Tapped(img: AnyObject)
    {
        
        pv = 1
        //tableView(UITableView,NSIndexPath)
        //let im = img as! UITapGestureRecognizer
        //let im = img as! String
        //print(AnyObject)
        
        //im.fadeOut()
        //image2.fadeIn()
    }
    func image2Tapped(img: AnyObject)
    {
        pv = 2
        //let im = img as? UITapGestureRecognizer
        //im!.fadeOut()
        //image2.fadeOut()
        //image1.fadeIn()
    }
    
    var currentObject : PFObject?
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.parseClassName = "Posts"
        self.textKey = "yourObject"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Posts")
        query.orderByAscending("createdAt")
        
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CardUI") as! CardUITableViewCell!
        if cell == nil {
            cell = CardUITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CardUI")
        }
        
        // Extract values from the PFObject to display in the table cell
        
        cell.prodDesc.text = object!["productDescription"] as? String
        cell.name.text = object!["userName"] as? String
        cell.objectId.text = object!.objectId
        
        print(cell.objectId.text)
        
        //cell.firstImage.image = object!["firstImage"] as! PFFile
        
        
        if let carImage = object!["firstImage"] as? PFFile {
            carImage.getDataInBackgroundWithBlock({
                (imageData: NSData?, error NSError) -> Void in
        //        if (error == nil) {
                let image = UIImage(data:imageData!)
                let tapGestureRecognizer1 = UITapGestureRecognizer(target:self, action:Selector("image1Tapped:"))
                cell.firstImage.userInteractionEnabled = true
                cell.firstImage.addGestureRecognizer(tapGestureRecognizer1)
                cell.firstImage.image = image
          //      }
            })
        }
        
        if let carImage = object!["secImage"] as? PFFile {
            carImage.getDataInBackgroundWithBlock({
                (imageData: NSData?, error NSError) -> Void in
                //        if (error == nil) {
                let image = UIImage(data:imageData!)
                let tapGestureRecognizer2 = UITapGestureRecognizer(target:self, action:Selector("image2Tapped:"))
                cell.secImage.userInteractionEnabled = true
                cell.secImage.addGestureRecognizer(tapGestureRecognizer2)
                cell.secImage.image = image
                //      }
            })
        }
        
        // Date for cell subtitle
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
      //  let dateForText = object?["updatedAt"] as! NSDate
      //  cell.Name.text = dateFormatter.stringFromDate(dateForText)
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        let detailScene = segue.destinationViewController as? CardUITableViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let row = Int(indexPath.row)
            detailScene!.currentObject = objects?[row] as? PFObject
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

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

public extension UIImageView {
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration duration: NSTimeInterval = 1.0) {
        UIImageView.animateWithDuration(duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(duration duration: NSTimeInterval = 1.0) {
        UIImageView.animateWithDuration(duration, animations: {
            self.alpha = 0.2
        })
    }
    
}
