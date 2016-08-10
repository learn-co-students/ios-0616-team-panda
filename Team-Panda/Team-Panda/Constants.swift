//
//  Constants.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SwiftFontName

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