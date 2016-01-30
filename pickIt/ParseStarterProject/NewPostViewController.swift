//
//  NewPostViewController.swift
//  pickIt
//
//  Created by Angela Mao on 1/30/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var productDes: UITextField!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secImage: UIImageView!
    
    let imagePick = UIImagePickerController()
    
    @IBAction func loadFirst(sender: AnyObject) {
        imagePick.allowsEditing = false;
        imagePick.sourceType = .PhotoLibrary
        
        presentViewController(imagePick, animated: true, completion: nil)
    }
    
    @IBAction func loadSec(sender: AnyObject) {
        imagePick.allowsEditing = false;
        imagePick.sourceType = .PhotoLibrary
        
        presentViewController(imagePick, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                firstImage.contentMode = .ScaleAspectFit
                firstImage.image = pickedImage
                secImage.contentMode = .ScaleAspectFit
                secImage.image = pickedImage
            }
            
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
                    let imageFileFirst = PFFile(name: firstImageFile, data: imageData)
                    myself!["firstImage"] = imageFileFirst
                }
                myself!.saveInBackgroundWithBlock {
                    (success, error) -> Void in
                }
                
                if let imageData = UIImageJPEGRepresentation(self.secImage.image!, 0.5){
                    let imageFileSec = PFFile(name: secImageFile, data: imageData)
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