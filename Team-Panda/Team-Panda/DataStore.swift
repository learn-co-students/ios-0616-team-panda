//
//  DataStore.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataStore {
    
    static let store = DataStore()
    var careerNameCellText: String!
    var careerResultsArray: [String] = []
    
    var tpUser : TPUser?
    
    private init() { }
    
    func getMultipleOccupationsWithCompletion(params : [String : AnyObject], completion: () -> ()) {
        
        self.careerResultsArray.removeAll()
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params) { (careerResults) in
            
            guard
                let resultsValue = careerResults["Results"] as? NSDictionary,
                let seriesValue = resultsValue["series"] as? [NSDictionary] else {
                    return
            }
            
            for seriesID in seriesValue {
                
                guard
                    let specificCareerDictionary = seriesID["catalog"] as? NSDictionary,
                    let careerName = specificCareerDictionary["occupation"] as? String else {
                        return
                }
                
                self.careerResultsArray.append(careerName)
                //self.careerResultsArray.append(seriesID)
                print("This is the count of my careerResultsArray: \(self.careerResultsArray.count)")
            }
            
          //  let specificCareerInfo = seriesValue[0]
//            guard
//                let specificCareerDictionary = specificCareerInfo["catalog"] as? NSDictionary,
//                let careerName = specificCareerDictionary["occupation"] as? String else {
//                    return
//            }
//            
//            self.careerNameCellText = careerName
//            print("Career name from API call: \(self.careerNameCellText)")
            completion()
        }
    }
}