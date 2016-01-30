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


class ContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        
        let request = CNContactFetchRequest(keysToFetch: toFetch)

        let store = CNContactStore()
        
        do{
            try store.enumerateContactsWithFetchRequest(request) {
                contact, stop in
                print(contact.givenName)
                print(contact.familyName)
                print(contact.identifier)
            }
        } catch let err{
            print(err)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var contactsTable: UITableView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

