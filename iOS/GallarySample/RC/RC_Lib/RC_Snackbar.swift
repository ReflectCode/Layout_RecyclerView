//****************************************************************************************
//  RC_Snackbar.swift
//
//  Copyright (C) 2020 Reflect Code Technologies (OPC) Pvt. Ltd.
//  For detailed please check - http://ReflectCode.com
//
//  Description - Swift implementation of Android snackbar control
//				  https://developer.android.com/reference/android/support/design/widget/Snackbar
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

class RC_Snackbar: UIView {

    static let LENGTH_INDEFINITE : Int = Int.max
    static let LENGTH_SHORT : Int = 5
    static let LENGTH_LONG : Int = 10

    private var snackBarHeight : CGFloat = 48.0

    private var messageLabel = UILabel()
    private var actionBtn = UIButton()
    private var actionBtnOnClick : ((UIButton) -> (Void))? = nil

    private var snackbarDuration: Int = 5
    private var mRootView: UIView = UIView()
    private var mAppView: UIView = UIView()
    private var mAppFooterView: UIView = UIView()
    private var mAppFooterViewLeadingConstraint = NSLayoutConstraint()
    private var mAppFooterViewHeightConstraint = NSLayoutConstraint()

    var snackBarPan = UIPanGestureRecognizer()
    var mainViewTap = UITapGestureRecognizer()

    var text : String {
        get{ return self.messageLabel.text!     }
        set{ self.messageLabel.text = newValue }
    }

    var duration : Int {
        get{ return self.snackbarDuration     }
        set{ self.snackbarDuration = newValue }
    }

// MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSnackBarView()

    }

    init(_ context : UIViewController){
        let screenSize: CGRect = UIScreen.main.bounds
        super.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: snackBarHeight))
        createSnackBarView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSnackBarView()
    }

	deinit {
		 NotificationCenter.default.removeObserver(self)
	}

    private func createSnackBarView(){
        let screenSize: CGRect = UIScreen.main.bounds
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: snackBarHeight)
        self.backgroundColor     = UIColor.lightGray
        self.alpha = 1

        self.addSubview(messageLabel)
        messageLabel.frame = CGRect(x: 8, y: 8, width: screenSize.width * 0.75 , height: snackBarHeight - 16 )
        messageLabel.text = "Default"

        self.addSubview(actionBtn)
        actionBtn.isEnabled = false
        actionBtn.alpha = 0
        actionBtn.frame = CGRect(x: screenSize.width * 0.80 , y: 8, width: screenSize.width * 0.20 - 8  , height: snackBarHeight - 16 )
        actionBtn.setTitle("Action", for: .normal)
        actionBtn.titleLabel?.textAlignment = .natural
        actionBtn.setTitleColor(UIColor.yellow, for: .normal)
	
		// ToDO - "NSNotification.Name.UIDeviceOrientationDidChange" is removed
        // NotificationCenter.default.addObserver(self, selector: #selector(self.updateSnackBarView), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    @objc private func updateSnackBarView(){
        let screenSize: CGRect = UIScreen.main.bounds
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: snackBarHeight)
        messageLabel.frame = CGRect(x: 8, y: 8, width: screenSize.width * 0.75 , height: snackBarHeight - 16 )
        actionBtn.frame = CGRect(x: screenSize.width * 0.80 , y: 8, width: screenSize.width * 0.20 - 8  , height: snackBarHeight - 16 )
        self.layoutIfNeeded()
    }

    private func makeSnackbar(v: UIView, text: String, duration: Int) -> RC_Snackbar {
        messageLabel.text = text
        snackbarDuration = duration
        var tempView = v
        while var parentView = tempView.superview {
            if parentView.restorationIdentifier == "Root-View" {
                mRootView = parentView
            }
            tempView = parentView
        }
        
        mAppView = mRootView.subviews[0]
        
        for subView in mRootView.subviews {
            if subView.tag == 101600222 {
                mAppFooterView = subView
            }
        }
        
        mAppFooterView.addSubview(self)

        for mConstaint in mRootView.constraints {
            if mConstaint.firstAttribute == .leading {
                mAppFooterViewLeadingConstraint = mConstaint
                mAppFooterViewLeadingConstraint.constant = 0
            }
        }

        for mConstaint in mAppFooterView.constraints {
            if mConstaint.firstAttribute == .height {
                mAppFooterViewHeightConstraint = mConstaint
                mAppFooterViewHeightConstraint.constant = 0
            }
        }

        return self
    }

    class func make(view: UIView, text: String, duration: Int) -> RC_Snackbar {
        return RC_Snackbar().makeSnackbar(v: view, text: text, duration: duration)
    }

    class func make(view: UIView, resID: Int, duration: Int) -> RC_Snackbar {
        return RC_Snackbar().makeSnackbar(v: view, text: RC_GetResources.getString(resID), duration: duration)
    }


    @objc func snackBarHandlePan(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
            case .ended:
                if mAppFooterViewLeadingConstraint.constant <= mRootView.frame.width / 2  {
                    mAppFooterViewLeadingConstraint.constant = 0
                    mAppFooterView.alpha = 1
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
                        self.mRootView.layoutIfNeeded()
                        }, completion: nil )
                } else {
                    self.mAppFooterViewLeadingConstraint.constant = UIScreen.main.bounds.width
                    mainViewHandleTap()
                }

            case .changed:
                let panTranslation = panGesture.translation(in: self.mAppFooterView)
                mAppFooterViewLeadingConstraint.constant = panTranslation.x
                mAppFooterView.alpha =  1 - panTranslation.x / mRootView.frame.width
                self.mRootView.layoutIfNeeded()

            default: break
        }

    }


    @objc func mainViewHandleTap() {
        mAppFooterViewHeightConstraint.constant = 0
        mAppFooterView.removeGestureRecognizer(snackBarPan)
        mAppFooterView.isUserInteractionEnabled = false
        mAppView.removeGestureRecognizer(mainViewTap)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.mRootView.layoutIfNeeded()
            }, completion: { (done) in
                self.mAppFooterView.alpha = 1
                self.mAppFooterViewLeadingConstraint.constant = 0
            }
        )
    }

// MARK: - Methods

    open func setAction( text: String,  delegate: ((UIButton) -> Void)?  ) -> RC_Snackbar {
        if delegate != nil {
            actionBtnOnClick = delegate
            actionBtn.isEnabled = true
            actionBtn.alpha = 1
            actionBtn.setTitle(text, for: .normal)
            actionBtn.addTarget(self, action:  #selector( self.actionBtnClicked(_:) ), for: .touchUpInside)
        }
        return self
    }

    open func setAction( resID: Int,  delegate: ((UIButton) -> Void)?  ) -> RC_Snackbar {
        return self.setAction(text: RC_GetResources.getString(resID), delegate: delegate)
    }

    @objc
    private func actionBtnClicked(_ item : UIButton) {
        mainViewHandleTap()
        if let btnClick = self.actionBtnOnClick {
            btnClick(item)
        }
        
    }

    open func setActionTextColor(color : UIColor) -> RC_Snackbar {
        actionBtn.setTitleColor(color, for: .normal)
        return self
    }

    open func setActionTextColor(color : Int) -> RC_Snackbar {
        actionBtn.setTitleColor(RC_GetResources.getColor(color, nil), for: .normal)
        return self
    }

    open func show(){
        if self.mAppFooterViewHeightConstraint.constant == snackBarHeight {
            mainViewHandleTap()  // If any Snackbar is visible then close it
        }

        self.mAppFooterView.alpha = 1
        self.mAppFooterViewLeadingConstraint.constant = 0
        self.mAppFooterViewHeightConstraint.constant = snackBarHeight

        self.snackBarPan = UIPanGestureRecognizer(target: self, action:#selector(self.snackBarHandlePan(_:)))
        self.mAppFooterView.addGestureRecognizer(self.snackBarPan)
        self.mAppFooterView.isUserInteractionEnabled = true

        self.mainViewTap = UITapGestureRecognizer(target: self, action:#selector(self.mainViewHandleTap))
        self.mAppView.addGestureRecognizer(self.mainViewTap)
        self.mAppView.isUserInteractionEnabled = true

        // Display snackbar with animation
        UIView.animate(withDuration: 0.5, delay: 0 , usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
                self.mRootView.layoutIfNeeded()
            }, completion: nil )

        // Remove snackbar after duration
        self.perform(#selector(mainViewHandleTap), with: nil, afterDelay: TimeInterval(snackbarDuration))

    }

    open func dismiss() {
        mainViewHandleTap()
    }

    open func getContext() -> RC_Snackbar{
        return self
    }

    open func getView() -> UIView {
        return self
    }

    open func isShown() -> Bool {
        return self.mAppFooterViewHeightConstraint.constant == snackBarHeight
    }

    open func isShownOrQueued()  -> Bool {
        return self.mAppFooterViewHeightConstraint.constant == snackBarHeight
    }


}
