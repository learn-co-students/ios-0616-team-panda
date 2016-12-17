//
//  JSONParser.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import SwiftyJSON
import SwiftSpinner

class JSONParser {
    
    static let sharedOccupationInstance = JSONParser()
    var occupationJSON: JSON!
    static let occupationtitle = "Title"
    static let occupationEdu = "Minimum Education Requirements"
    static let occupationDescription = "Description"
    static let occupationBecomeOne = "How to Become One"
    
    func parsingJSON() {
        
        if let path = Bundle.main.path(forResource: "Occupation-Dictionary2", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
                self.occupationJSON = JSON(data: data)
                
                if self.occupationJSON != JSON.null {
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print("There was a problem retrieving the JSON object \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func sortingOccupationBySOCCode(_ socCode: String) -> [String: JSON] {

        self.parsingJSON()
        var occupationData: [String: JSON] = [:]
        
        var i = 0
        while i < self.occupationJSON.arrayValue.count {
            let occupationDict = self.occupationJSON[i].dictionaryValue
            
            if occupationDict.keys.first == socCode {
                if let occupationDatabase = occupationDict[socCode] {
                    occupationData = occupationDatabase.dictionaryValue
                } else {
                    print("There was an issue pulling the data for the Occupation by SOC Code in the JSON Parser.")
                }
            }
            i += 1
        }
        return occupationData
    }
    
    func dashCode(_ code: Int) -> String {
        
        var codeString = String(code)
        codeString.insert("-", at: codeString.characters.index(codeString.startIndex, offsetBy: 2))
        
        return codeString
        
    }
    
    func matchingUpTheCodes() -> [String] {
        
        self.parsingJSON()
        let apiCodesArray = ComparingCodes().sortingOccupationBySOCCode()
        var matchingCodes: [String] = []
        
        var i = 0
        while i < self.occupationJSON.arrayValue.count {
            
            let occupationDict = self.occupationJSON[i].dictionaryValue
            
            for code in apiCodesArray {
                if occupationDict.keys.first == code {
                    matchingCodes.append(code)
                }
            }
            i += 1
        }
        
        return matchingCodes
    }
}
