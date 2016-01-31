//
//  CardUITableViewCell.swift
//  pickIt
//
//  Created by Loren Yeung on 29/4/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class CardUITableViewCell: PFTableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var prodDesc: UITextView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBInspectable var cornerRadius: CGFloat = 2
    
//    @IBInspectable var shadowOffsetWidth: Int = 0
//    @IBInspectable var shadowOffsetHeight: Int = 3
//    @IBInspectable var shadowColor: UIColor? = UIColor.blackColor()
//    @IBInspectable var shadowOpacity: Float = 0.5
    
//    override func layoutSubviews() {
//        layer.cornerRadius = cornerRadius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        
//        layer.masksToBounds = false
//        layer.shadowColor = shadowColor?.CGColor
//        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = shadowPath.CGPath
//    }

}
