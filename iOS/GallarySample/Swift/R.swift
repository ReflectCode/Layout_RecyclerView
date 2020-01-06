//
//  R.swift
//  Project : GallarySample
//
//  Auto generated by ReflectCode.com 
//
//  R.swift file to hold the details of resources used in the project
//  Used for compatibility with swift code generated from Android code
//

// The MIT License (MIT)
//
// Copyright (c) 2020 Reflect Code Technologies (OPC) Pvt. Ltd. (http://ReflectCode.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import UIKit
 
extension UIView {
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}
 
    //*** Struct for all resources used in project
    struct R {
 
    //*** Struct for tag assigned to UI resources
        struct id {
            static let RC_ID_1000 = 1000
            static let imageGalleryView = 1001
            static let RC_ID_1002 = 1002
            static let img = 1003
            static let RC_ID_1004 = 1004
            static let title = 1005
            static let btnSelect = 1006
        }
 
 
    //*** Struct for tag assigned to Layout files (xib and storyboard)
        struct layout {
            static let activity_main                  = 0
            static let cell_layout                    = 1
        }
 
        public static let layoutResources :[String] = ["activity_main", "cell_layout", ]
 
 
    //*** Structure for String resources IDs
        struct string {
            static let app_name                       = 100000
        }

        public static let stringResources :[String] = [  "string_app_name" ] 
 
 
    //*** Struct for Array resources of various types
        struct array {
        }

        public static let arrayResources :[String] = [ ] 
 
 
    //*** Struct for Dimention resources
        struct dimen {
            static let activity_horizontal_margin     = 300000
            static let activity_vertical_margin       = 300001
        }

        public static let dimenResources :[String] = [  "dimen_activity_horizontal_margin", "dimen_activity_vertical_margin" ] 
 
 
    //*** Structure for Boolean resources
        struct bool {
        }

        public static let boolResources :[String] = [ ] 
 
 
    //*** Struct for Color values defined in project
        struct color {
            static let colorPrimary                   = 500000
            static let colorPrimaryDark               = 500001
            static let colorAccent                    = 500002
            static let colorLightBlue                 = 500003
            static let colorOrange                    = 500004
        }

        public static let colorResources :[String] = [  "colorPrimary", "colorPrimaryDark", "colorAccent", "colorLightBlue", 
                          "colorOrange" ] 
 
 
    //*** structure for Integer type of resources
        struct integer {
        }

        public static let integerResources :[String] = [ ] 
 
 
    //*** Structure of IDs for all Drawable resources
        struct drawable {
            static let img1                           = 800000
            static let img2                           = 800001
            static let img3                           = 800002
            static let img4                           = 800003
            static let img5                           = 800004
            static let img6                           = 800005
            static let img7                           = 800006
            static let img8                           = 800007
        }

        public static let drawableFileName :[String] = [  "img1" , "img2" , "img3" , "img4" , "img5" , "img6" , "img7" , 
                          "img8"  ] 
 
    }
 
// --[ End of R.swift ]-- 

