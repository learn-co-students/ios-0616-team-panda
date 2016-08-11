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

let jobsDictionary : [WhichInterestsStyle : AnyObject] =
    
    [WhichInterestsStyle.SolveProblem :
        // 31-9000 - 31-9099 range
        ["Human Body": [19-3011, 19-3031, 19-3032, 19-3039, 31-2011, 31-2012, 31-2020, 31-9000, 31-9099, 35-0000, 53-3010],
                // [319011, 319091, 319092, 319093, 319094, 319095, 319096, 319097, 351011, 351012, 352011, 352012, 352013, 352014, 352015, 352019, 352021, 353011, 353021, 353022, 353031, 353041, 359011, 359021, 359031, 359099]
            
            
         // 19-3000-19-3099, 37-3000-37-3019, 45-0000-45-4029, 51-0000-51-9199
         "Environment" : [19-3000, 19-3099, 37-3000, 37-3019, 45-0000, 45-4029, 51-0000, 51-9199],
                // [193011, 193022, 193031, 193032, 193039, 193041, 193051, 193091, 193092, 193093, 193094, 373011, 373012, 373013, 451011, 452011, 452021, 452041, 452091, 452092, 452093, 452099, 453011, 454011, 454021, 454022, 454023, 511011, 512011, 512021, 512022, 512023, 512031, 512041, 512091, 512092, 512093, 512099, 513011, 513021, 513022, 513023, 513091, 513092, 513093, 513099, 514011, 514012, 514021, 514022, 514023, 514031, 514032, 514033, 514034, 514035, 514041, 514051, 514052, 514061, 514062, 514071, 514072, 514081, 514111, 514121, 514122, 514191, 514192, 514193, 514194, 514199, 515111, 515112, 515113, 516011, 516021, 516031, 516041, 516042, 516051, 516052, 516061, 516062, 516063, 516064, 516091, 516092, 516093, 516099, 517011, 517021, 517031, 517032, 517041, 517042, 517099, 518011, 518012, 518013, 518021, 518031, 518091, 518092, 518093, 518099, 519011, 519012, 519021, 519022, 519023, 519031, 519032, 519041, 519051, 519061, 519071, 519081, 519082, 519083, 519111, 519121, 519122, 519123, 519141, 519151, 519191, 519192, 519193, 519194, 519195, 519196, 519197, 519198]
            
            
         // 53-0000 53-7199
         "Transportation" : [53-0000, 53-7199],
         
         // 17-0000-17-3031, 27-4000-27-4090, 47-00000-47-5099, 49-0000-49-9099, 51-0000-51-9199
         "Architecture" : [17-0000, 17-3031, 27-4000, 27-4090, 47-00000, 47-5099, 49-0000, 49-9099, 51-0000, 51-9199],
         
         // 15-0000-15-2099, 19-3000-19-3099, 25-1000-25-9099,
         "Teaching" : [15-0000, 15-2099, 19-3000, 19-3099, 25-1000, 25-9099, 27-1020, 27-4030, 35-0000, 35-2019] ],

    WhichInterestsStyle.UnderstandProblem :
        // 13-0000 - 13-2099, 19-3000-19-409,
        ["Human body": [13-0000, 13-2099, 19-3000, 19-409, 31-9090],
            
         // 17-0000-17-3031, 19-3000-19-4099, 25-1040-25-1069, 25-1080-25-1082, 45-4021-45-4029
         "Environment" : [17-0000, 17-3031, 19-3000, 19-4099, 25-1040, 25-1069, 25-1080, 25-1082, 45-4011, 45-4021, 45-4029],
            
         "Transportation" : [53-2020, 53-4020],
         
         // 17-0000-17-3031, 47-0000-47-5099, 49-0000-49-9099
         "Architecture" : [17-0000, 17-3031, 47-0000, 47-5099, 49-0000, 49-9099],
            
         // 15-0000-15-2099, 19-3000-19-4099, 25-1020-25-1032, 27-1000-27-1029
         "Teaching" : [15-0000, 15-2099, 19-3000, 19-4099, 25-1020, 25-1032, 27-1000, 27-1029] ],

    WhichInterestsStyle.IdeaExpressed :
        ["Law" : [0],
            
         "History & Society" : [27-3000],
            
         "Art" : [27-1010, 27-4020],
            
         "Sports" : [27-2000],
            
         "Teaching" : [25-1060, 25-2000],
            
         "Health" : [21-0000] ],
    
    WhichInterestsStyle.IdeasFormed :
        ["Law" : [23-0000, 33-0000],
            
         "History & Society" : [19-3000, 27-3000],
            
         "Teaching" : [25-1060, 25-1190],
            
         "Health" : [21-0000, 29-1120, 31-1000],
            
         "Leadership" : [11-0000],
            
         "Finance" : [41-3030] ]
]

let solveProblemArray = ["Human Body", "Environment", "Transportation", "Architecture", "Teaching"]
let underStandProblemArray = solveProblemArray
let ideaExpressedArray = ["Law", "History & Society", "Art", "Sports", "Teaching", "Health"]
let ideaFormedArray = ["Law", "History & Society", "Leadership", "Finance", "Teaching", "Health"]
