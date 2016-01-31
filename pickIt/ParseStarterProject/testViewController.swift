//
//  testViewController.swift
//  pickIt
//
//  Created by Brian Wichers on 1/30/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image1.image = UIImage(named: "example_image.png")
        image2.image = UIImage(named: "example_image.png")
        let tapGestureRecognizer1 = UITapGestureRecognizer(target:self, action:Selector("image1Tapped:"))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target:self, action:Selector("image2Tapped:"))
        image1.userInteractionEnabled = true
        image1.addGestureRecognizer(tapGestureRecognizer1)
        image2.userInteractionEnabled = true
        image2.addGestureRecognizer(tapGestureRecognizer2)
        
    }
    
    func image1Tapped(img: AnyObject)
    {
        image1.fadeOut()
        image2.fadeIn()
    }
    func image2Tapped(img: AnyObject)
    {
        image2.fadeOut()
        image1.fadeIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

public extension UIImageView {
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    /*func fadeIn(duration duration: NSTimeInterval = 1.0) {
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
    }*/
    
}