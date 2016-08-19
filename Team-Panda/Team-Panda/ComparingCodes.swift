//
//  ComparingCodes.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SwiftyJSON

class ComparingCodes {
    
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
        
       // let occupation = self.sortingOccupationBySOCCode("19-1012")
        //print("Printing occupation data from parsingJSON function: \(occupation)")
        
    }
    
    func sortingOccupationBySOCCode() {
        
        var occupationData: [String: JSON] = [:]
        
        var matchingCodes: [String] = []
        
        var mutableJobsDictionary = jobsDictionary
        
        let whichInterestSolveProblem  = mutableJobsDictionary[WhichInterestsStyle.SolveProblem] as? [String : [Int]]
        let whichInterestsUnderstandProblem = mutableJobsDictionary[WhichInterestsStyle.UnderstandProblem] as? [String : [Int]]
        let whichInterestIdeaExpressed = mutableJobsDictionary[WhichInterestsStyle.IdeaExpressed] as? [String : [Int]]
        let whichInterestIdeaFormed = mutableJobsDictionary[WhichInterestsStyle.IdeasFormed] as? [String : [Int]]
        
        let solveHuman = whichInterestSolveProblem!["Human Body"]?.map({ dashCode($0) })
        let solveEnvironment = whichInterestSolveProblem!["Environment"]?.map({ dashCode($0) })
        let solveTranspo = whichInterestSolveProblem!["Transportation"]?.map({ dashCode($0) })
        let solveArc = whichInterestSolveProblem!["Architecture"]?.map({ dashCode($0) })
        let solveTeach = whichInterestSolveProblem!["Teaching"]?.map({ dashCode($0) })
        let understandHuman = whichInterestsUnderstandProblem!["Human Body"]?.map({ dashCode($0) })
        let understandEnvironment = whichInterestsUnderstandProblem!["Environment"]?.map({ dashCode($0) })
        let understandTranspo = whichInterestsUnderstandProblem!["Transportation"]?.map({ dashCode($0) })
        let understandArc = whichInterestsUnderstandProblem!["Architecture"]?.map({ dashCode($0) })
        let understandTeach = whichInterestsUnderstandProblem!["Teaching"]?.map({ dashCode($0) })
        let expressedHistory = whichInterestIdeaExpressed!["History & Society"]?.map({ dashCode($0) })
        let expressedArt = whichInterestIdeaExpressed!["Art"]?.map({ dashCode($0) })
        let expressedSports = whichInterestIdeaExpressed!["Sports"]?.map({ dashCode($0) })
        let expressedTeaching = whichInterestIdeaExpressed!["Teaching"]?.map({ dashCode($0) })
        let expressedHealth = whichInterestIdeaExpressed!["Health"]?.map({ dashCode($0) })
        let formedLaw = whichInterestIdeaFormed!["Law"]?.map({ dashCode($0) })
        let formedHistory = whichInterestIdeaFormed!["History & Society"]?.map({ dashCode($0) })
        let formedTeach = whichInterestIdeaFormed!["Teaching"]?.map({ dashCode($0) })
        let formedHealth = whichInterestIdeaFormed!["Health"]?.map({ dashCode($0) })
        let formedLeadership = whichInterestIdeaFormed!["Leadership"]?.map({ dashCode($0) })
        let formedFinance = whichInterestIdeaFormed!["Finance"]?.map({ dashCode($0) })
        
        
        let interestsArray =  [solveHuman, solveEnvironment, solveTranspo, solveArc, solveTeach, understandHuman, understandEnvironment, understandTranspo, understandArc, understandTeach, expressedHistory, expressedArt, expressedSports, expressedTeaching, expressedHealth, formedLaw, formedHistory, formedTeach, formedHealth, formedLeadership, formedFinance]
        
        let interests2 = interestsArray.flatMap { $0 }
        let interest3 = interests2.flatMap { $0 }
        
     
        
        
        var i = 0
        while i < self.occupationJSON.arrayValue.count {

            let occupationDict = self.occupationJSON[i].dictionaryValue

            
            for code in interest3 {
                
                if (occupationDict.keys.first!.containsString(code)) {
                    
                    matchingCodes.append(code)
                    
                }
                
            }
//            
//            if ((occupationDict.keys.first?.containsString(solveHuman[i])) != nil) {
//                
//                if let occupationDatabase = occupationDict[socCode] {
//                    
//                    occupationData = occupationDatabase.dictionaryValue
//                    print("These are the educational requirements: \(occupationData[JSONParser.occupationEdu]?.stringValue)")
//                    
//                } else {
//                    
//                    print("There was an issue pulling the data for the Occupation by SOC Code in the JSON Parser.")
//                }
//            }
            
            i += 1
        }
        
        print("These are the matching codes: \(matchingCodes)")
        
       // return occupationData
        
    }
    
    func dashCode(code: Int) -> String {
        
        var codeString = String(code)
        
        codeString.insert("-", atIndex: codeString.startIndex.advancedBy(2))
        
        return codeString
        
    }


}