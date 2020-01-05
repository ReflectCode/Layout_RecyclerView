//****************************************************************************************
//  RC_GetResources.swift
//
//  Copyright (C) 2020 Reflect Code Technologies (OPC) Pvt. Ltd.
//  For detailed please check - http://ReflectCode.com
//
//  Description - Swift implementation of Android Resource class to extract the xcAsset resources.  
//				  https://developer.android.com/reference/android/content/res/Resources
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

import Foundation
import UIKit

public class RC_GetResources : NSObject {

    // Seriese of values used for data type
    static let idID       : Int = 1000
    static let stringID   : Int = 100000
    static let arrayID    : Int = 200000
    static let dimenID    : Int = 300000
    static let boolID     : Int = 400000
    static let colorID    : Int = 500000
    static let integerID  : Int = 700000
    static let drawableID : Int = 800000

    //**** Returns localized string of given id
    //     Handles the screen specific conversion
    class public func getString(_ id:Int) -> String {

        if id < self.stringID || id > self.stringID + R.stringResources.count {
            return  ""
        }
        let stringID = R.stringResources[ id - self.stringID ]
        let returnVal = NSLocalizedString(stringID, comment: stringID)
        return returnVal
    }


    //**** Same as getString()
    class public func getText(_ id:Int) -> String {
        return getString(id)
    }


    //**** Returns array of localized string for a given id
    //        Localizable.strings file should be in below format -
    //        "StrArr1" = "String1";
    //        "StrArr2" = "String2";
    //        "StrArr3" = "String3";
    //
    //        id value to get array is "StrArr"
    //
    class public func getStringArray(_ id:Int) -> [String] {
        var returnArray : [String] = []
        var tempValue : String
        var idArr : String

        if id < arrayID || id > arrayID + R.arrayResources.count {
            return  []
        }

        let arrayName : String = NSLocalizedString(R.arrayResources[ id - arrayID ], comment: "")

        for i in 1 ... 10000 {        // ToDo : Need to remove hardcoading of upper limit of for loop
            idArr = arrayName + "_\(i)"
            tempValue = NSLocalizedString(idArr , comment: "" )
            if tempValue != idArr {
                returnArray.append(tempValue)
            }
            else { break }
        }
        return returnArray
    }



    //**** Returns localized string for a given id
    class public func obtainTypedArray(_ id: Int) -> [String] {
        return getStringArray( id )
    }



    //**** Returns array of integers created using localized string for a given id
    class public func getIntArray (_ id: Int) -> [Int] {
        var returnArray : [Int] = []
        var tempValue : String
        var idArr : String

        if id < arrayID || id > arrayID + R.arrayResources.count {
            return []
        }

        let arrayname : String = NSLocalizedString(R.arrayResources[ id - arrayID ], comment: R.arrayResources[ id - arrayID ])

        for i in 1 ... 10000 {        // ToDo : Need to remove hardcoading of upper limit of for loop
            idArr = arrayname + "_\(i)"
            tempValue = NSLocalizedString(idArr , comment: "" )
            if tempValue != idArr {
                returnArray.append(Int(tempValue)!)
            }
            else { break }
        }
        return returnArray
    }




    //**** Returns dimentioned in pixels from a localized version of given id
    //     Handles the screen specific conversion for units : dp, pt, px, mm, in, dp, sp
    class public func getDimension(_ id:Int) -> Float {

        if id < dimenID || id > dimenID + R.dimenResources.count {
            return  0.0
        }

        let resourceName = R.dimenResources[ id - dimenID ]
        let resourceText = NSLocalizedString(resourceName, comment: resourceName)
        let unitIndex = resourceText.index(resourceText.endIndex, offsetBy: -2)
        let resourceUnit = String(resourceText[unitIndex ..< resourceText.endIndex ])
        let resourceValueText  = String( resourceText[resourceText.startIndex ..< unitIndex] )
        var resourceValue  = Float(resourceValueText) ?? 0.0

        if resourceUnit == "dp" {
            // ToDo : Check if 'resourceValue' needs any modification

        }else if resourceUnit == "pt" {
            // ToDo : Check if 'resourceValue' needs any modification

        }else if resourceUnit == "px" {
            // ToDo : Check if 'resourceValue' needs any modification

        }else if resourceUnit == "mm" {
            // Converting mm to points @ 160 points / inch
            resourceValue = resourceValue * 6.299

        }else if resourceUnit == "in" {
            // Converting inch to points @ 160 points / inch
            resourceValue = resourceValue * 160

        }else if resourceUnit == "sp" {
            // ToDo : Check if 'resourceValue' needs any modification

        }else {
            // ToDo : Check if 'resourceValue' needs any modification

        }

        return resourceValue
    }


    //**** Returns boolean from a localized string for a given id
    class public func getBoolean(_ id:Int) -> Bool {

        if id < boolID || id > boolID + R.boolResources.count {
            return  false
        }

        let returnValue = NSLocalizedString(R.boolResources[ id - boolID ], comment: R.boolResources[ id - boolID ])
        return  returnValue.lowercased() == "true"
    }



    //**** Returns localized color for a given id
    //     Valid values - rgb = "#789"  ,  argb = "#80a8"  ,  rrggbb = "#ff6600"  ,  aarrggbb = "#aa440066"
    class public func getColor(_ id:Int, _ theme : String? ) -> UIColor {

        if id < colorID || id > colorID + R.colorResources.count {
            return  UIColor(white: 1, alpha: 1)
        }

        let returnValue : String  = R.colorResources[ id - colorID ]
        if let returnColor = UIColor(named: returnValue) {
             return returnColor
        } else {
            print("a2i : Color value not found is asset catalog")
            return UIColor(white: 1, alpha: 1)
        }
    }

	
    //**** Returns color object for a given string
    //     Valid values - rgb = "#789"  ,  argb = "#80a8"  ,  rrggbb = "#ff6600"  ,  aarrggbb = "#aa440066"
    class public func getColor(_ colorValue : String , _ theme : String? ) -> UIColor {

        var returnValue = colorValue
        var valueIndex = returnValue.index(returnValue.endIndex, offsetBy: -1)
        var valueIndexOffset : Int

        var scanner = Scanner(string: returnValue)

        var strAlpha, strRed, strGreen, strBlue : String
        strAlpha = "" ; strRed = "" ; strGreen = "" ; strBlue = ""

        var alpha, red, green, blue, divideBy : Float
        alpha = 1.0 ;   red = 1.0 ;   green = 1.0 ;   blue = 1.0  ;  divideBy = 15

        if returnValue.hasPrefix("#") {

            returnValue.remove(at: returnValue.startIndex)

            if returnValue.count == 3  {          // Format #rgb
                valueIndexOffset = 1
                returnValue.insert("F", at: returnValue.startIndex)

            } else if returnValue.count == 4  {    // Format #argb
                valueIndexOffset = 1

            } else if returnValue.count == 6  {    // Format #rrggbb
                valueIndexOffset = 2
                returnValue.insert("F", at: returnValue.startIndex)
                returnValue.insert("F", at: returnValue.startIndex)
                divideBy = 255

            } else if returnValue.count == 8  {    // Format #aarrggbb
                valueIndexOffset = 2
                divideBy = 255

            } else {                                // Invalid format
                return UIColor(white: 1, alpha: 1)
            }

            valueIndex = returnValue.index(returnValue.startIndex, offsetBy: valueIndexOffset)

            strAlpha = "0x" + String(returnValue[ returnValue.startIndex ..< valueIndex ])
            scanner = Scanner(string: strAlpha)
            if scanner.scanHexFloat(&alpha) {
                red = red / divideBy
            } else {
                red = 0.0
            }

            returnValue.remove(at: returnValue.startIndex)
            if divideBy == 255 {  returnValue.remove(at: returnValue.startIndex) }

            strRed = "0x" + String(returnValue[ returnValue.startIndex ..< valueIndex ])
            scanner = Scanner(string: strRed)
            if scanner.scanHexFloat(&red) {
                red = red / divideBy
            } else {
                red = 0.0
            }

            returnValue.remove(at: returnValue.startIndex)
            if divideBy == 255 {  returnValue.remove(at: returnValue.startIndex) }

            strGreen = "0x" + String(returnValue[ returnValue.startIndex ..< valueIndex ])
            scanner = Scanner(string: strGreen)
            if scanner.scanHexFloat(&green) {
                green = green / divideBy
            } else {
                green = 0.0
            }

            returnValue.remove(at: returnValue.startIndex)
            if divideBy == 255 {  returnValue.remove(at: returnValue.startIndex) }

            strBlue = "0x" + String(returnValue[ returnValue.startIndex ..< valueIndex ])
            scanner = Scanner(string: strBlue)
            if scanner.scanHexFloat(&blue) {
                blue = blue / divideBy
            } else {
                blue = 0.0
            }

            return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))

        } else {
            print("a2i : Invalid color value")
            return UIColor(white: 1, alpha: 1)
        }
    }

    //**** Returns ID
    // ToDo : Not required
    //
    //class public func getInteger( id:String) -> Int {
    // if id < idID || id > idID + R.idResources.count {
    //        return 1
    //}


    //**** Returns integer of a localized string for a given id
    class public func getInteger(_ id : Int) -> Int {

        if id < integerID || id > integerID + R.integerResources.count {
            return 0
        }

        if let returnValue = Int(NSLocalizedString(R.integerResources[ id - integerID ], comment: R.integerResources[ id - integerID ])) {
            return returnValue
        } else {
            return 0
        }
    }

	
    //**** Returns UIImage object for a given int id	
	class public func getDrawable(_ id:Int) -> UIImage {

        if id < drawableID || id > drawableID + R.drawableFileName.count {
            return  UIImage( named: "RC_help")!
        }

        if let img =  UIImage( named: R.drawableFileName[ id - drawableID ]) {
            return img
        } else {
            return UIImage( named: "RC_help")!   // Default place holder image
        }
    }

}
