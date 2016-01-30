//
//  ContactsViewController.swift
//  pickIt
//
//  Created by Matthew Wang on 1/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Contacts
import Parse


class ContactsViewController: UITableViewController  {
    
    var myContacts : [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey]
        
        let request = CNContactFetchRequest(keysToFetch: toFetch)
        
        let store = CNContactStore()
        
        do{
            try store.enumerateContactsWithFetchRequest(request) {
                contact, stop in
                
                let theContact = contact as CNContact
                self.myContacts.append(theContact)
                
            }
        } catch let err{
            print(err)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contact_cell", forIndexPath: indexPath)
        cell.textLabel?.text = CNContactFormatter.stringFromContact(myContacts[indexPath.item], style: .FullName)
        return cell
    }
    
    @IBAction func contact_button(sender: AnyObject) {
        
    }
    @IBOutlet weak var contactsTable: UITableView!
    
    //override func viewDidAppear(animated: Bool) {
    //    super.viewDidAppear(animated)
    //    contactsTable.reloadData()
    //}
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
