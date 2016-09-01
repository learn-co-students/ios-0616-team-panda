//
//  Constants.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SwiftFontName
import SwiftSpinner
import Firebase
import Font_Awesome_Swift

class Constants {
    
    class func displayAlertWith(title: String, message: String, actionLabel : String, style : UIAlertActionStyle, actionHandler: () -> ()) -> UIAlertController {
       
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: actionLabel, style: style) { (action) in
            actionHandler()
        }
        
        alertController.addAction(action)
        
        return alertController
        
    }
    
    class func displayAlertWithTryAgain(title: String, message: String) -> UIAlertController {
        
        let userAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let newUserCancelAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
        userAlertController.addAction(newUserCancelAction)
        return userAlertController
    }
    
    class func displayAlertWithVerify(title : String, message : String) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (email) in
            email.placeholder = "Current Email Address"
        }
        
        alertController.addTextFieldWithConfigurationHandler { (password) in
            password.placeholder = "Password"
            password.secureTextEntry = true
        }
        
        let logInAction = UIAlertAction(title: "Log In", style: .Default) { (action) in
            
            SwiftSpinner.show("Authenticating")
            
            FIRAuth.auth()?.signInWithEmail(alertController.textFields![0].text!, password: alertController.textFields![1].text!, completion: { (user, error) in
                
                if let error = error {
                    SwiftSpinner.showWithDuration(2.0, title: "Couldn't Log In", animated: false)
                    print(error.localizedDescription)
                }
                else {
                    SwiftSpinner.showWithDuration(2.0, title: "Logged In!\nPlease tap save again.", animated: false)
                    print("Succesfully logged in. Should update profile info.")
                }
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(logInAction)
        alertController.addAction(cancelAction)
        
        return alertController
        
    }
    
    class func displayAlertWithContinueAndCancel(title : String, message : String, continueHandler : ()->(), cancelHandler : ()->()) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let continueAction = UIAlertAction(title: "Continue", style: .Default) { (action) in
            continueHandler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            cancelHandler()
        }
        
        alertController.addAction(continueAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
}

extension UIColor {
    
    class func systemBlue() -> UIColor {
        return UIColor(colorLiteralRed: 14.0/255, green: 122.0/255.0, blue: 254.0/255.0, alpha: 1.0)
    }

    
}

extension UIFont {
    class func pandaFontBold(withSize size : CGFloat) -> UIFont {
        return UIFont(name: FontName.HelveticaNeueBold, size: size)!
    }
    
    class func pandaFontMedium(withSize size : CGFloat) -> UIFont {
        return UIFont(name: FontName.HelveticaNeueMedium, size: size)!
    }
    
    class func pandaFontLight(withSize size : CGFloat) -> UIFont {
        return UIFont(name: FontName.HelveticaNeueLight, size: size)!
    }
}

let checkMarkImage = UIImage(named: "checkmark")!
let faveStar = UIImage(icon: FAType.FAStar, size: CGSizeMake(25.0, 25.0))


let databaseRefURL = "https://career-options.firebaseio.com/"
let solveProblemArray = ["Human Body", "Environment", "Transportation", "Architecture", "Teaching"]
let underStandProblemArray = solveProblemArray
let ideaExpressedArray = ["History & Society", "Art", "Sports", "Teaching", "Health"]
let ideaFormedArray = ["Law", "History & Society", "Leadership", "Teaching", "Health"]