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
import FirebaseAuth
import Font_Awesome_Swift

class Constants {
    
    class func displayAlertWith(_ title: String, message: String, actionLabel : String, style : UIAlertActionStyle, actionHandler: @escaping () -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionLabel, style: style) { (action) in
            actionHandler()
        }
        
        alertController.addAction(action)
        
        return alertController
        
    }
    
    class func displayAlertWithTryAgain(_ title: String, message: String) -> UIAlertController {
        
        let userAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let newUserCancelAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
        userAlertController.addAction(newUserCancelAction)
        return userAlertController
    }
    
    class func displayAlertWithVerify(_ title : String, message : String) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (email) in
            email.placeholder = "Current Email Address"
        }
        
        alertController.addTextField { (password) in
            password.placeholder = "Password"
            password.isSecureTextEntry = true
        }
        
        let logInAction = UIAlertAction(title: "Log In", style: .default) { (action) in
            
            SwiftSpinner.show("Authenticating")
            
            FIRAuth.auth()?.signIn(withEmail: alertController.textFields![0].text!, password: alertController.textFields![1].text!, completion: { (user, error) in
                
                if let error = error {
                    SwiftSpinner.show(duration: 2.0, title: "Couldn't Log In")
                    print(error.localizedDescription)
                }
                else {
                    SwiftSpinner.show(duration: 2.0, title: "Logged In!\nPlease tap save again.")
                    print("Succesfully logged in. Should update profile info.")
                }
            })
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logInAction)
        alertController.addAction(cancelAction)
        
        return alertController
        
    }
    
    class func displayAlertWithContinueAndCancel(_ title : String, message : String, continueHandler : @escaping ()->(), cancelHandler : @escaping ()->()) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            continueHandler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
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
let faveStar = UIImage(icon: FAType.FAStar, size: CGSize(width: 25.0, height: 25.0))


let databaseRefURL = "https://career-options.firebaseio.com/"
let solveProblemArray = ["Human Body", "Environment", "Transportation", "Architecture", "Teaching"]
let underStandProblemArray = solveProblemArray
let ideaExpressedArray = ["History & Society", "Art", "Sports", "Teaching", "Health"]
let ideaFormedArray = ["Law", "History & Society", "Leadership", "Teaching", "Health"]
