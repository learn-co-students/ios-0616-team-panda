//
//  DataStore.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import SwiftyJSON

class DataStore {
    
    static let store = DataStore()
    var careerNameCellText: String!
    var careerResultsArray: [String] = []
    var jobsResultsArray : [Job] = []
    var jobDiscoverData : [[Job]] = []
    var tpUser : TPUser?
    lazy var sectionHeaders : [String] = ["110000", "130000", "150000", "170000", "190000", "210000", "230000", "250000", "270000", "290000", "310000", "350000", "370000", "450000", "470000", "490000", "510000", "530000"] // "330000", "390000", "410000", "430000"
    
    fileprivate init() { }
    
    func getMultipleOccupationsWithCompletion(_ params : [String : Any], completion: @escaping (Error?) -> ()) {
        
        self.careerResultsArray.removeAll()
        self.jobsResultsArray.removeAll()
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params: params) { (careerResults, error) in
            
            if let error = error {
                
                completion(error)
                
            } else if let careerResults = careerResults {
                
                guard
                    let resultsValue = careerResults["Results"] as? NSDictionary,
                    let seriesValue = resultsValue["series"] as? [[String : Any]] else {
                        print("There was a problem getting the seriesValue from the DataStore.")
                        let error = NSError(domain: "Connection Failed", code: 9000, userInfo: nil)
                        completion(error)
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
                completion(nil)
            }
        }
    }
    
    func getSingleOccupationWithCompletion(_ params : [String : Any], completion: @escaping (Job?, Error?) -> ()) {
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params: params) { (careerResults, error) in
            
            if let error = error {
                
                completion(nil, error)
                
            } else if let careerResults = careerResults {
                
                guard
                    let resultsValue = careerResults["Results"] as? NSDictionary,
                    let seriesValue = resultsValue["series"] as? [[String : Any]] else {
                        return
                }
                completion(Job(withDictionary: seriesValue.first!), nil)
            }
        }
    }
    
    func getLocationQuotientforSOCCodeWithCompletion(_ SOCcode : String, completion : @escaping ([String : Double]?, Error?) -> ()) {
        
        var lqByState : [String : Double] = [:]
        
        let stateParams = DataSeries.createStateSeriesIDsWith(SOCcode, withDataType: DataSeries.locationQuotient)
        
        BLSAPIClient.getLocationQuotientforJobWithCompletion(params: stateParams) { (lqResults, error) in
            
            if let error = error {
                
                completion(nil, error)
                
            } else if let lqResults = lqResults {
                guard
                    let resultsValue = lqResults["Results"] as? NSDictionary,
                    let seriesValue = resultsValue["series"] as? [[String : Any]] else {
                        let error = NSError(domain: "Network Error", code: 9000, userInfo: nil)
                        completion(nil, error)
                        return
                }
                
                for state in seriesValue {
                    
                    guard
                        let stateSeriesInfo = state["catalog"] as? NSDictionary,
                        let stateName = stateSeriesInfo["area"] as? String,
                        let stateData = state["data"] as? [[String : Any]],
                        let lqValue = stateData[0]["value"] as? String
                        else {
                            let error = NSError(domain: "No Location Quotient", code: 9999, userInfo: nil)
                            completion(nil, error)
                            return
                        }
                    
                    if let locQuotientFloat = Double(lqValue) {
                        lqByState.updateValue(locQuotientFloat, forKey: stateName)
                    }
                }
                completion(lqByState, nil)
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
