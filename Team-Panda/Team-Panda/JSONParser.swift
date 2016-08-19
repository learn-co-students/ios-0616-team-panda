//
//  JSONParser.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParser {
    
    static let sharedOccupationInstance = JSONParser()
    var occupationJSON: JSON!
    static let occupationtitle = "Title"
    static let occupationEdu = "Minimum Education Requirements"
    static let occupationDescription = "Description"
    static let occupationBecomeOne = "How to Become One"
    
    
    func parsingJSON() {
        
        if let path = NSBundle.mainBundle().pathForResource("Occupation-Dictionary2", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                self.occupationJSON = JSON(data: data)
                
                if self.occupationJSON != JSON.null {
                    
                    //     print("jsonData:\(self.occupationJSON)")
                    
                } else {
                    
                    print("could not get json from file, make sure that file contains valid json.")
                    
                }
                
            } catch let error as NSError {
                
                print(error.localizedDescription)
                
            }
            
        } else {
            
            print("Invalid filename/path.")
            
        }
        
                let occupation = self.occupationJSON[0]["19-1012"].dictionaryValue
                print("Inside JSON Parser: \(occupation)")
        // self.sortingOccupationBySOCCode("19-1012")
    }
    
    func sortingOccupationBySOCCode(socCode: String) {
        
        
    }
}