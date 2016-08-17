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
    var jobsResultsArray : [Job] = []
    
    var tpUser : TPUser?
    
    private init() { }
    
    func getMultipleOccupationsWithCompletion(params : [String : AnyObject], completion: () -> ()) {
        
        self.careerResultsArray.removeAll()
        self.jobsResultsArray.removeAll()
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params) { (careerResults) in
            
            guard
                let resultsValue = careerResults["Results"] as? NSDictionary,
            let seriesValue = resultsValue["series"] as? [[String : AnyObject]] else {
                    return
            }
            
            //print("Results Value: \(resultsValue)")
            
            for seriesID in seriesValue {
                let job = Job(withDictionary: seriesID)
                print(job)
                guard
                    let specificCareerDictionary = seriesID["catalog"] as? NSDictionary,
                    let careerName = specificCareerDictionary["occupation"] as? String else {
                        return
                }
                self.careerResultsArray.append(careerName)

           // XMLParser().parsingXML()
                self.jobsResultsArray.append(job)
                //print("This is the count of my careerResultsArray: \(self.careerResultsArray.count)")
            }

            completion()
        }
    }
    
    func getLocationQuotientforSOCCodeWithCompletion(SOCcode : String, completion : ([String : Double]) -> ()) {
        
        var lqByState : [String : Double] = [:]
        
        let stateParams = DataSeries.createStateSeriesIDsWith(SOCcode, withDataType: DataSeries.locationQuotient)
        
        BLSAPIClient.getLocationQuotientforJobWithCompletion(stateParams) { (lqResults) in
            
            guard
                let resultsValue = lqResults["Results"] as? NSDictionary,
                let seriesValue = resultsValue["series"] as? [[String : AnyObject]] else {
                    return
            }
            
            for state in seriesValue {
                
                guard
                    let stateSeriesInfo = state["catalog"] as? NSDictionary,
                    let stateName = stateSeriesInfo["area"] as? String,
                    let stateData = state["data"] as? [[String : AnyObject]],
                    let lqValue = stateData[0]["value"] as? String
                    else { return }
                
                if let locQuotientFloat = Double(lqValue) {
                    lqByState.updateValue(locQuotientFloat, forKey: stateName)
                }
            }
            completion(lqByState)
        }
    }
}