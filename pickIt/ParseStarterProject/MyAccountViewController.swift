//
//  MyAccountViewController.swift
//  pickIt
//
//  Created by Brian Wichers on 1/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class MyAccountViewController: UIViewController {


    
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var nameValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editing = false
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            let currentId = currentUser?.objectId
            let query = PFUser.query()
            query!.getObjectInBackgroundWithId(currentId!) {
                (myself: PFObject?, error: NSError?) -> Void in
                if error == nil && myself != nil {
                    self.emailValue.text = myself!["email"]as? String
                    self.nameValue.text = myself!["username"]as?String

                }
            
            }
        }

        // Dany additional setup after loading the view.
    }
    func notEditingAccount(){
        emailValue.userInteractionEnabled = false
        nameValue.userInteractionEnabled = false
        editing = false
        editButtonItem().title = "Edit Account"
        
        let currentId = PFUser.currentUser()?.objectId
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId(currentId!) {
            (myself: PFObject?, error: NSError?) -> Void in
            if error == nil && myself != nil {
                myself!["name"] = self.nameValue.text
                myself!["email"] = self.emailValue.text
                
                myself!.saveInBackgroundWithBlock {
                    (success, error) -> Void in
                }
            }
            else {
                print(error)
            }
        }
    }

    func editingAccount(){
        emailValue.userInteractionEnabled = true
        nameValue.userInteractionEnabled = true
        editButtonItem().title = "Save"
        editing = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func editAccount(sender: AnyObject) {
        if editing == false{
            editingAccount()
        }
        if editing == true{
            notEditingAccount()
        }
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
