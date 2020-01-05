//****************************************************************************************
//  RC_UILabel.swift
//
//  Copyright (C) 2020 Reflect Code Technologies (OPC) Pvt. Ltd.
//  For detailed please check - http://ReflectCode.com
//
//  Description - Custom UILabel Swift class to add image behind the text 
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//  software and associated documentation files (the "Software"), to deal in the Software 
//  without restriction, including without limitation the rights to use, copy, modify, merge,
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or 
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//****************************************************************************************

//
// ToDo 1 : Add image behind the text
// Note   : Solutions to add image behind test are not working, as of now UIImageView is added behind the UILabel during Storyboard generation
//
// ToDo 2 : Add padding to all four sides
// Note   : Padding add is working but only at run time, Its not updated in storyboard
//

import UIKit

@IBDesignable class RC_UILabel: UILabel {

    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    @IBInspectable var backImage: String = ""       // Used to set the image at back of text.
    
    
    override func drawText(in rect: CGRect) {
        
        // Set padding to text
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        
        if backImage != "" {
            // Solution 1 : Insert UIImage view
            // var bkImg = UIImageView(image: UIImage(named: backImage))
            // bkImg.frame = self.bounds
            // self.insertSubview(bkImg, at: 0)    // Image gets streteched, and text goes behind the image
            
            // Solution 2 : Add image to layer content
            // self.layer.contents = UIImage(named: backImage)?.cgImage      // Image not displayed
            
            // Solution 3 : Add CALayer with image
            // var bkCALayer = CALayer()
            // bkCALayer.contentsGravity = CALayerContentsGravity.resize
            // bkCALayer.contents = UIImage(named: backImage)?.cgImage
            // bkCALayer.frame = super.bounds
            // bkCALayer.opacity = 1
            // super.layer.addSublayer(bkCALayer)                           // Text goes behind the image
            // super.layer.insertSublayer(bkCALayer, below: super.layer)    // Text goes behind the image
            
        }
 
        super.drawText(in: rect.inset(by: insets))

    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        if backImage != "" {
            // Solution 1 : Insert UIImage view
            // var bkImg = UIImageView(image: UIImage(named: backImage))
            // bkImg.frame = self.bounds
            // self.insertSubview(bkImg, at: 0)    // Image gets streteched, and text goes behind the image
            
            // Solution 2 : Add image to layer content
            // self.layer.contents = UIImage(named: backImage)?.cgImage      // Image not displayed
            
            // Solution 3 : Add CALayer with image
            // var bkCALayer = CALayer()
            // bkCALayer.contentsGravity = CALayerContentsGravity.resize
            // bkCALayer.contents = UIImage(named: backImage)?.cgImage
            // bkCALayer.frame = super.bounds
            // bkCALayer.opacity = 1
            // super.layer.addSublayer(bkCALayer)                           // Text goes behind the image
            // super.layer.insertSublayer(bkCALayer, below: super.layer)    // Text goes behind the image

        }
        
        super.draw(layer, in: ctx)
    }
    
    override var intrinsicContentSize: CGSize {
        // Set the control size as per padding values
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }

}

