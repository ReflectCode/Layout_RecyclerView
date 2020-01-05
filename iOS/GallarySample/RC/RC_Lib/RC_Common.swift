//****************************************************************************************
//  RC_Common.swift
//
//  Copyright (C) 2020 Reflect Code Technologies (OPC) Pvt. Ltd.
//  For detailed please check - http://ReflectCode.com
//
//  Description - Common utilities used in project converted by ReflectCode.com 
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

	// Constants used to return result when user press back button on Navigation control
	// Reference - https://developer.android.com/reference/android/app/Activity.html#RESULT_OK
	struct Rc_result {
		static let RESULT_OK         : Int = -1
		static let RESULT_CANCELED   : Int =  0
		static let RESULT_FIRST_USER : Int =  1
	}

	// This protocol defines the delegate function which will be invoked by called ViewController to 
	// send data back to calling ViewController  
	// It represents android method - https://developer.android.com/reference/android/app/Activity.html#onActivityResult(int,%2520int,%2520android.content.Intent)
	protocol Rc_resultHandlerDelegate : AnyObject {
		func Rc_onActivityResult( _ requestCode:Int, _ resultCode:Int, _ data: [String:Any]) -> Void
	}


	extension CALayer{
		// This method is used to set CALayer color from Storyboard
		func shadowUIColor(color : UIColor){
			self.shadowColor = color.cgColor
		}
	}


	extension Comparable {
        // https://docs.oracle.com/javase/7/docs/api/java/lang/Comparable.html#compareTo(T)
        // Extension to provide android like Int.compareTo(Int) feature
        // e.g.  10.compareTo(20) will return -1
        // e.g.  10.compareTo(10) will return 0
        // e.g.  10.compareTo(2) will return 1
        
        func RC_compareTo(_ anotherObject : Self?) throws -> Int {
			
            if object_getClass(self) != object_getClass(anotherObject) {
				throw NSError(domain: "ClassCastException", code: 0, userInfo: nil)
			}
			
			if anotherObject == nil {
				throw NSError(domain: "NullPointerException", code: 0, userInfo: nil)
			}
			
			if self == anotherObject {
				return 0
			} else if self < anotherObject! {
				return -1
			} else {
				return 1
			}
		}
	}

    extension String {
        // Extension to provide android like compareTo() functionality
		func RC_compareTo(_ anotherString : String) -> Int {
			
			if self == anotherString {
				return 0
			} else if self < anotherString {
				return -1
			} else {
				return 1
			}
		}

		func RC_compareToIgnoreCase(_ anotherString : String) -> Int {
			if self.lowercased() == anotherString.lowercased() {
				return 0
			} else if self.lowercased() < anotherString.lowercased() {
				return -1
			} else {
				return 1
			}
		}
		
		func RC_matches(_ pattern: String) -> Bool {
			guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return false }
			let str = self as NSString
			let result = regex.matches(in: self, options: [], range: NSMakeRange(0, str.length))
			
			if result.count == 0 {
				return false
			} else {
				return true
			}        
		}
		
		func RC_regionMatches(_ ignoreCase : Bool, _ toffset : Int, _ other : String, _ ooffset : Int, _ len : Int) -> Bool {
			
			let thisStrArray = Array(self)
			let compareStrArray = Array(other)
			
			if (toffset+len) >= thisStrArray.count {
				return false
			}
			
			if (ooffset+len) >= compareStrArray.count {
				return false
			}
			
			var thisStr : String = String(thisStrArray[toffset...(toffset+len)])
			var compareStr : String = String(compareStrArray[ooffset...(ooffset+len)])
			
			if ignoreCase {
				thisStr = thisStr.lowercased()
				compareStr = compareStr.lowercased()
			}
			
			return  thisStr.RC_compareTo(compareStr) == 0
		}
	 
		func RC_regionMatches(_ toffset : Int, _ other : String, _ ooffset : Int, _ len : Int) -> Bool {
			return self.RC_regionMatches(true, toffset, other, ooffset, len)
		}

		
		func RC_replaceAll(_ pattern : String, _ replacement : String) -> String {
			// String.replaceAll method which uses regular expression to find string to be replaced
			guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
			let result = regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: replacement)
			return result
		}

		func RC_replaceFirst(_ pattern : String, _ replacement : String) -> String {
			// String.replaceFirst method which uses regular expression to find string to be replaced
			var result = self

			guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
			let firstMatchRange = regex.rangeOfFirstMatch(in: self, options: [], range: NSMakeRange(0, self.count))
			result = regex.stringByReplacingMatches(in: self, options: [], range: firstMatchRange, withTemplate: replacement)
			
			return result
		}
        
	}

	public extension Comparable {
		// Entension to provide Java Comparable.compareTo()
		// https://docs.oracle.com/javase/7/docs/api/java/lang/Comparable.html
		// ToDo : throw
		// ToDo : throw NullPointerException - if the specified object is null
		// ToDo : throw ClassCastException - if the specified object's type prevents it from being compared to this object.
		
		func compareTo(_ ele: Self) -> Int {
			
			// Warning : Comparing non-optional valye of type 'self' to 'nil' always returns false
			// if ele == nil {
			//	  return 1
			// }
			
			if self > ele {
				return 1
			} else if self < ele {
				return -1
			} else {
				return 0
			}
		}   
	}

	// Gravity used by RC_DrawerController.swift
    public enum RC_Gravity: Int{
        case START, END
    }
    

	// UIView extention to get the view which is currently focused
	// This is to implement the Android like functionality of Activity.getCurrentFocus()
	// https://developer.android.com/reference/android/app/Activity.html#getCurrentFocus()
	// This is in reference of : https://stackoverflow.com/questions/1823317/get-the-current-first-responder-without-using-a-private-api
	extension UIView {
		func RC_GetCurrentFocus() -> UIView? {
			guard !isFirstResponder else { return self }
			for subview in subviews {
				if subview.isFirstResponder {
					return subview
				}
			}
			return nil
		}
	}
	
	
	// Swift implementation of Java synchronized block
	// https://docs.oracle.com/javase/tutorial/essential/concurrency/locksync.html
	// Note : Java synchronized methods are converted into synchronized block by moving 
	//        complete code of method inside synchronized block
	// Usage : Rc_synchronized(self){
	//				<< Block of swift statements to be synchronized >>
	//         }
	//
    func Rc_synchronized(_ lock: Any, closure: () -> () ) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
	
    //  Android Ref : https://developer.android.com/reference/java/lang/Thread.State
    enum Rc_Thread_State{
        case NEW
        case RUNNABLE
        case BLOCKED
        case WAITING
        case TIMED_WAITING
        case TERMINATED
    }


    //  Android Ref : https://developer.android.com/reference/java/lang/Thread.html#getState()
    extension Thread{
        
        func getState() -> Rc_Thread_State {
            if self.isExecuting {
                return Rc_Thread_State.RUNNABLE
                
            } else if self.isCancelled{
                return Rc_Thread_State.BLOCKED
                
            } else if self.isFinished {
                return Rc_Thread_State.TERMINATED
                
            } else {
                return Rc_Thread_State.NEW
                
            }
        }
    }


	// Overload '+' operator to concatinate strings
	// Non string objects will be converted into string using its .description method

	public func +(left: Any, right: String) -> String {
		return "\(left)\(right)"
	}

	public func +(left: String, right: Any) -> String {
		return "\(left)\(right)"
	}
