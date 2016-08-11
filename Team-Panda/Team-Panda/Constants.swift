//
//  Constants.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SwiftFontName

class Constants {
    
    class func displayAlertWithTryAgain(title: String, message: String) -> UIAlertController {
        
        let userAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let newUserCancelAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
        userAlertController.addAction(newUserCancelAction)
        return userAlertController
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

let databaseRefURL = "https://career-options.firebaseio.com/"

//Panda Blue Hex = 394D82


//let jobDictionary : [WouldYouRatherStyle : AnyObject]
//    
//        = [ WouldYouRatherStyle.Make : [WhichInterestsStyle.SolveProblem : "",
//                                        WhichInterestsStyle.UnderstandProblem : ""],
//            
//            WouldYouRatherStyle.Think : [WhichInterestsStyle.IdeaExpressed : "",
//                                         WhichInterestsStyle.IdeasFormed : ""]
//          ]
//
//let interestsDictionary = [WhichInterestsStyle.SolveProblem : "",
//    WhichInterestsStyle.UnderstandProblem : ""]


