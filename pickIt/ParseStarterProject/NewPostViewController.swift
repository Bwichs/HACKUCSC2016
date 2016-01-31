//
//  NewPostViewController.swift
//  pickIt
//
//  Created by Angela Mao on 1/30/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var productDes: UITextField!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secImage: UIImageView!
    
    let imagePick1 = UIImagePickerController()
    let imagePick2 = UIImagePickerController()
    
    @IBAction func loadFirst(sender: AnyObject) {
        imagePick1.allowsEditing = false;
        imagePick1.sourceType = .PhotoLibrary
        
        presentViewController(imagePick1, animated: true, completion: nil)
    }
    
    @IBAction func loadSec(sender: AnyObject) {
        imagePick2.allowsEditing = false;
        imagePick2.sourceType = .PhotoLibrary
        
        presentViewController(imagePick2, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePick1.delegate = self
        imagePick2.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
                if let pickedImage1 = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    if picker == imagePick1 {
                        firstImage.contentMode = .ScaleAspectFit
                        firstImage.image = pickedImage1
                    } else {
                        secImage.contentMode = .ScaleAspectFit
                        secImage.image = pickedImage1
                    }
                }
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitChanges(sender: AnyObject) {
        let currectId = PFUser.currentUser()?.objectId
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId(currectId!) {
            (myself: PFObject?, error: NSError?) -> Void in
            if error == nil && myself != nil {
                myself!["productDescription"] = self.productDes.text
                
                let firstImageFile = "firstImage.jpg"
                let secImageFile = "secImage.jpg"
                
                if let imageData = UIImageJPEGRepresentation(self.firstImage.image!, 0.5){
                    let imageFile = PFFile(name: firstImageFile, data: imageData)
                    myself!["firstImage"] = imageFile
                }
                myself!.saveInBackgroundWithBlock {
                    (success, error) -> Void in
                }
                
                if let imageDataSec = UIImageJPEGRepresentation(self.secImage.image!, 0.5){
                    let imageFileSec = PFFile(name: secImageFile, data: imageDataSec)
                    myself!["secImage"] = imageFileSec
                }
                myself!.saveInBackgroundWithBlock {
                    (success, error) -> Void in
                }
                
            }
            else {
                print(error)
            }
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