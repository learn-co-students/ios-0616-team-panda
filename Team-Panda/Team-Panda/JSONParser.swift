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
                    
                    
                } else {
                    
                    print("could not get json from file, make sure that file contains valid json.")
                    
                }
                
            } catch let error as NSError {
                
                print(error.localizedDescription)
                
            }
            
        } else {
            
            print("Invalid filename/path.")
            
        }
        
        let occupation = self.sortingOccupationBySOCCode("19-1012")
        print("Printing occupation data from parsingJSON function: \(occupation)")
        
    }
    
    func sortingOccupationBySOCCode(socCode: String) -> [String: JSON] {
        
        var occupationData: [String: JSON] = [:]
        
        var i = 0
        while i < self.occupationJSON.arrayValue.count {
            
            let occupationDict = self.occupationJSON[i].dictionaryValue
            
            if occupationDict.keys.first == socCode {
                
                
                
                if let occupationDatabase = occupationDict[socCode] {
                    
                    occupationData = occupationDatabase.dictionaryValue
                    
//                    let specificData = occupationDatabase[dataForOccupation]
//                    occupationData = specificData.stringValue
                    
                } else {
                    
//                    occupationData = "There was a problem getting the occupationDatabase by SOC Code!"
//                    print(occupationData)
                    
                }
            }
            
            i += 1
        }
        
        return occupationData
        
    }
}