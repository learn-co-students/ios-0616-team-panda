//
//  ComparingCodes.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import SwiftyJSON

class ComparingCodes {
    
    func sortingOccupationBySOCCode() -> [String] {
        
        var codesFromJobsDictionary: [String] = []
        /*
         PUTTING ALL THE SOC CODES FROM THE JOBS DICTIONARY INTO ONE ARRAY
         */
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
        
        let allSoc = allSOCCodes
        
        var dummyArray: [String] = []
        
        for majorOccupation in allSoc.values {
            
            for codes in majorOccupation.keys {
                
                let codesDash = dashCode(Int(codes)!)
                codesFromJobsDictionary.append(codesDash)
                dummyArray.append(codes)
            }
        }
        // codesFromJobsDictionary = formedFinance.flatMap{ $0 }!
        
        let interestsArray =  [solveHuman, solveEnvironment, solveTranspo, solveArc, solveTeach, understandHuman, understandEnvironment, understandTranspo, understandArc, understandTeach, expressedHistory, expressedArt, expressedSports, expressedTeaching, expressedHealth, formedLaw, formedHistory, formedTeach, formedHealth, formedLeadership, formedFinance]
        let interests2 = interestsArray.flatMap { $0 }
        codesFromJobsDictionary = interests2.flatMap { $0 }
        codesFromJobsDictionary = Array(Set(codesFromJobsDictionary))
        
        return codesFromJobsDictionary
        
    }
    
    func dashCode(code: Int) -> String {
        
        var codeString = String(code)
        codeString.insert("-", atIndex: codeString.startIndex.advancedBy(2))
        
        return codeString
        
    }
}