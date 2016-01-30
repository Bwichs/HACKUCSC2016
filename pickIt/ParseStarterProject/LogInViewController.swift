/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    override func viewDidAppear(animated: Bool) {
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do stuff with the user
            
            //self.performSegueWithIdentifier("go_to_app", sender: self)
            
        } else {
            // Show the signup or login screen
        }
    }
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        super.viewDidLoad()
        view.addGestureRecognizer(tap)
        
        // Handle the text field's user input through delegate callbacks
        emailAddress.delegate = self
        password.delegate = self
        userName.delegate = self
        userName.returnKeyType = UIReturnKeyType.Next
        emailAddress.returnKeyType = UIReturnKeyType.Next
        password.returnKeyType = UIReturnKeyType.Done
        emailAddress.autocorrectionType = .No
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        if textField == emailAddress {
            password.becomeFirstResponder()
        }
        if textField == password {
            registerOrSignIn(self)
        }
        
        return false
    }
    
    // MARK: Actions
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func registerOrSignIn(sender: AnyObject) {
        var userEmailAddress = emailAddress.text
        let userPassword = password.text
        
        // Ensure username is lowercase
        userEmailAddress = userEmailAddress!.lowercaseString
        // Ensure email is @ucsc.edu
        
        
        // Start activity indicator
        loading.hidden = false
        loading.startAnimating()
        
        // Create the user
        let user = PFUser()
        user.username = userEmailAddress
        user.password = userPassword
        user.email = userEmailAddress
        
        PFUser.logInWithUsernameInBackground(userEmailAddress!, password: (userPassword)!) {
            (return_user: PFUser?, error: NSError?) -> Void in

                if return_user != nil {
                    //Verify email
                    if return_user?["emailVerified"] as! Bool == true {
                        self.loading.stopAnimating()
                        dispatch_async(dispatch_get_main_queue()) {
                            /*self.performSegueWithIdentifier(
                                "go_to_app",
                                sender: self)*/
                        }
                    }
                    else {
                        self.signIn_alert("Email address verification",
                            alert_message: "We have sent you an email that contains a link - you must click this link before you can continue.")
                    }
                } else {
                    // The login failed. Check error to see why. Either incorrect password, or does not exist yet
                    self.try_signUp(user)
                }
            }
    }
    
    func try_signUp(user: PFUser) {
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                _ = error.userInfo["error"] as? NSString
                // User is already registered, password was incorrect
                self.signIn_alert("Password incorrect",
                    alert_message: "Email in use, please enter correct password.")
            } else {
                // Account registered, please verify email
                self.signIn_alert("Email address verification",
                    alert_message: "We have sent you an email that contains a link - you must click this link before you can continue.")
            }
        }
        
    }
    
    func signIn_alert(alert_title: String, alert_message: String) {
        self.loading.stopAnimating()
        let alertController = UIAlertController(title: alert_title, message: alert_message,
                preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
