//****************************************************************************************
//  RC_toast.swift
//
//  Copyright (C) 2020 Reflect Code Technologies (OPC) Pvt. Ltd.
//  For detailed please check - http://ReflectCode.com
//
//  Description - Swift implementation of Android Toast class
//				  https://developer.android.com/guide/topics/ui/notifiers/toasts
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

import UIKit
import Foundation


public enum ToastGravity {
    case Start
    case Left
    case End
    case Right
    case Top
    case Center
    case Bottom
}


public enum ToastDuration :Int {
    case Short = 2
    case Long = 4
}


public class RC_Toast: UIView {
    private var mText            : String = ""
    private var mGravity         : ToastGravity = ToastGravity.Bottom
    private var mDuration        : ToastDuration = ToastDuration.Short
    private var mXOffset         : Int = 0
    private var mYOffset         : Int = 0
    private var mHMargin         : Int = 8
    private var mVMargin         : Int = 8
    private var mToastView       : UIView = UIView()
    private var mToastViewWidth  : Int  = 0
    private var mToastViewHeight : Int = 0
    private var mParentView      : UIView = UIView()

    
    // **** Properties related to toast position on screen
    public func setGravity(gravity : ToastGravity , xOffset : Int, yOffset : Int ){
        mGravity = gravity
        mXOffset = xOffset
        mYOffset = yOffset
    }

    
    var gravity : ToastGravity {
        get{ return self.mGravity }
    }

    
    var xOffset : Int {
        get{ return self.mXOffset }
    }

    
    var yOffset: Int {
        get{ return self.mYOffset }
    }


    // **** Properties related to spacing between toast text and toast border
    public func setMargin(horizontalMargin : Int, verticalMargin : Int ){
        mHMargin = horizontalMargin
        mVMargin = verticalMargin
    }

    
    var horizontalMargin : Int {
        get{ return self.mHMargin }
    }
    
    
    var verticalMargin: Int {
        get{ return self.mVMargin }
    }


    // **** Properties related to behaviour of Toast message
    var text : String {
        get{ return self.mText     }
        set{ self.mText = newValue }
    }

    
    var duration : ToastDuration {
        get{ return self.mDuration     }
        set{ self.mDuration = newValue }
    }

    
    // **** Properties to set custom layout to Toast message
    var view : UIView {
        get{ return self.mToastView }
        set{
            self.mToastViewHeight        = Int(newValue.bounds.height)
            self.mToastViewWidth         = Int(newValue.bounds.width)
            newValue.layer.shadowColor   = UIColor.black.cgColor
            newValue.layer.shadowOpacity = 0.5
            newValue.layer.shadowRadius  = 10
            newValue.layer.cornerRadius  = 10
            newValue.layer.shadowOffset  = CGSize(width: 1.0, height: 1.0)
            newValue.alpha               = 0
            newValue.clipsToBounds       = false
            self.mToastView = newValue
        }
    }

    
    // **** Initialize the Toast object
    // **** Construct an empty Toast object. You must call setView(View) before you can call show().
    init(_ context : UIViewController){
        super.init(frame: CGRect(x: 0 , y: 0 , width: 100, height: 100))
        self.mParentView = context.view!
        
        // ToDo - check how to detect device orientation change event
        // NotificationCenter.default.addObserver(self, selector: #selector(self.DismissToast), name: NSNotification.Name.UIDevice.orientationDidChangeNotification, object: nil)
    }

	deinit {
		NotificationCenter.default.removeObserver(self)
	}
		
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    // **** If device orientation is changed then close the toast
    @objc func DismissToast() {
        self.mToastView.removeFromSuperview()
    }


    
    // **** Factory method to create toast message with detault layout and properties
    class func makeText(context : UIViewController , text : String , duration : ToastDuration ) -> RC_Toast {
        let newToast = RC_Toast( context )
            newToast.mText       = text
            newToast.mDuration   = duration
            newToast.mParentView = context.view!

        let ToastScreen = UIView()
            ToastScreen.layer.cornerRadius  = 8
            ToastScreen.backgroundColor     = UIColor.lightGray
            ToastScreen.layer.shadowColor   = UIColor.black.cgColor
            ToastScreen.layer.shadowOpacity = 0.3
            ToastScreen.layer.shadowRadius  = 8
            ToastScreen.layer.shadowOffset  = CGSize(width: 1.0, height: 1.0)

        let ToastTextLabel = UILabel()
            ToastTextLabel.tag              = 919191919191
            ToastTextLabel.text             = text
            ToastTextLabel.backgroundColor  = UIColor.clear
            ToastTextLabel.textAlignment    = NSTextAlignment.center

        let ToastTextLabelBounds = ToastTextLabel.sizeThatFits(CGSize(width: newToast.mParentView.bounds.size.width , height: newToast.mParentView.bounds.size.height ) )

        ToastTextLabel.frame = CGRect(x: newToast.mHMargin / 2 , y: newToast.mVMargin / 2 , width: Int(ToastTextLabelBounds.width) + newToast.mHMargin, height: Int(ToastTextLabelBounds.height) + newToast.mVMargin )

        ToastScreen.addSubview(ToastTextLabel)

        newToast.mToastViewHeight  = Int(ToastTextLabel.bounds.height) + newToast.mVMargin
        newToast.mToastViewWidth   = Int(ToastTextLabel.bounds.width) + newToast.mHMargin
        newToast.mToastView.alpha  = 0.0
        newToast.mToastView        = ToastScreen
        return newToast
    }

    
    // **** Method to display Toast message
    public func show() {
        var durationInSec = 4
        var ToastLocationX : Int
        var ToastLocationY : Int

        var screenWidth  = Int(UIScreen.main.bounds.width)
        var screenHeight = Int(UIScreen.main.bounds.height)

        screenWidth = screenWidth - ( screenWidth / 20 )        //  5 % reduction in width
        screenHeight = screenHeight - ( screenHeight / 10 )     // 10 % reduction in height

        if let textLabel = mToastView.viewWithTag( 919191919191 ) {
            let textLabelView = textLabel as! UILabel   // The toast text might be changed so compute the size again
            textLabelView.text = self.mText
            textLabelView.numberOfLines = 6
            let ToastTextLabelBounds = textLabelView.sizeThatFits(CGSize(width: screenWidth , height: screenHeight ) )

            mToastViewHeight  = Int(ToastTextLabelBounds.height) + self.mVMargin
            mToastViewWidth   = Int(ToastTextLabelBounds.width) + self.mHMargin

            textLabelView.frame = CGRect(x: self.mHMargin / 2 , y: self.mVMargin / 2 , width: mToastViewWidth , height: mToastViewHeight )
         }

        switch (self.mGravity) {
            case ToastGravity.Start, ToastGravity.Left :
                 ToastLocationX = screenWidth / 40 + self.xOffset
                 ToastLocationY = screenHeight / 2  - mToastViewHeight / 2

            case ToastGravity.End, ToastGravity.Right :
                 ToastLocationX = screenWidth      - mToastViewWidth - screenWidth / 40 - self.xOffset
                 ToastLocationY = screenHeight / 2 - mToastViewHeight / 2

            case ToastGravity.Top :
                 ToastLocationX = screenWidth / 2 - mToastViewWidth / 2
                 ToastLocationY = 64 + screenHeight / 20 +  self.yOffset

            case ToastGravity.Center :
                 ToastLocationX = screenWidth  / 2 - mToastViewWidth  / 2 + self.xOffset
                 ToastLocationY = screenHeight / 2 - mToastViewHeight / 2 + self.yOffset

            case ToastGravity.Bottom :
                 ToastLocationX = screenWidth / 2 - mToastViewWidth / 2
                 ToastLocationY = screenHeight    - mToastViewHeight - screenHeight / 20 - self.yOffset
        }

        mToastView.frame = CGRect(x: ToastLocationX, y: ToastLocationY, width: mToastViewWidth + mHMargin , height: mToastViewHeight + mVMargin )

        let parentView = self.mParentView
        parentView.addSubview(self.mToastView)

        if mDuration == ToastDuration.Short { 
			durationInSec = 2 
		} else { 
			durationInSec = 4 
		}

        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut],
            animations: { () -> Void in self.mToastView.alpha = 1.0 },
            completion: {   finished in
                UIView.animate(withDuration: 0.25 , delay: TimeInterval(durationInSec), options: [.curveEaseIn, .beginFromCurrentState],
                    animations: { () -> Void in   self.mToastView.alpha = 0.0           },
                    completion: {   finished in   self.mToastView.removeFromSuperview() }
                )
            }
		)
    }

    
    // *** Method to close toast that is dispayed on UI
    public func cancel() {
        var durationInSec = 4

        if mDuration == ToastDuration.Short { 
			durationInSec = 2 
		} else { 
			durationInSec = 4 
		}

        UIView.animate(withDuration: 1.0 , delay: TimeInterval(durationInSec), options: [.curveEaseIn, .beginFromCurrentState],
            animations: { () -> Void in   self.mToastView.alpha = 0.0           },
            completion: {   finished in   self.mToastView.removeFromSuperview() }
        )
    }


}
