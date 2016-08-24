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
    var jobDiscoverData : [[Job]] = []
    
    var tpUser : TPUser?
    
    lazy var sectionHeaders : [String] = ["110000", "130000", "150000", "170000", "190000", "210000", "230000", "250000", "270000", "290000", "310000", "330000", "350000", "370000", "390000", "410000", "430000", "450000", "470000", "490000", "510000", "530000"]
    
    private init() { }
    
    func getMultipleOccupationsWithCompletion(params : [String : AnyObject], completion: () -> ()) {
        
        self.careerResultsArray.removeAll()
        self.jobsResultsArray.removeAll()
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params) { (careerResults, error) in
            
            if let careerResults = careerResults {
                guard
                    let resultsValue = careerResults["Results"] as? NSDictionary,
                    let seriesValue = resultsValue["series"] as? [[String : AnyObject]] else {
                        return
                }
                
                
                for seriesID in seriesValue {
                    let job = Job(withDictionary: seriesID)
                    
                    guard
                        let specificCareerDictionary = seriesID["catalog"] as? NSDictionary,
                        let careerName = specificCareerDictionary["occupation"] as? String else {
                            return
                    }
                    self.careerResultsArray.append(careerName)
                    
                    self.jobsResultsArray.append(job)
                }
                
                completion()
            }
        }
    }
    
    func getSingleOccupationWithCompletion(params : [String : AnyObject], completion: (Job) -> ()) {
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params) { (careerResults, error) in
            
            if let careerResults = careerResults {
                guard
                    let resultsValue = careerResults["Results"] as? NSDictionary,
                    let seriesValue = resultsValue["series"] as? [[String : AnyObject]] else {
                        return
                }
                
                completion(Job(withDictionary: seriesValue.first!))
            }
        }
        
    }
    
    func getLocationQuotientforSOCCodeWithCompletion(SOCcode : String, completion : ([String : Double]) -> ()) {
        
        var lqByState : [String : Double] = [:]
        
        let stateParams = DataSeries.createStateSeriesIDsWith(SOCcode, withDataType: DataSeries.locationQuotient)
        
        BLSAPIClient.getLocationQuotientforJobWithCompletion(stateParams) { (lqResults, error) in
            
            if let lqResults = lqResults {
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
    
    func getJobDiscoverArray() {
        
        for section in sectionHeaders {
            
            var jobArray : [Job] = []
            
            let occupations = allSOCCodes[section]!
            
            for (socCode, occupation) in occupations {
                
                let job = Job(withSOCCode: socCode, occupation: occupation)
                jobArray.append(job)
            }
            
            self.jobDiscoverData.append(jobArray)
        }
    }
}