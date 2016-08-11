//
//  BLSAPIClient.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire

class BLSAPIClient {
    
    
    class func getMultipleOccupationsWithCompletion(completion: (NSDictionary) -> ()) {
        
        let header = [
            "Content-Type" : "application/json",
            ]
        let params = [
            "seriesid" : ["OEUN000000000000013201104", "OEUN000000000000027102504", "OEUN000000000000025112104"],
            // Sample seriesID's...
            "startyear":"2015",
            "endyear":"2015",
            "catalog":true,
            "calculations":true,
            "annualaverage":true,
            "registrationKey":"0f531a05be854c279b9476729a303269"
        ]
        
        Alamofire.request(.POST, Secrets().apiURL, parameters: params, encoding: .JSON, headers: header).responseJSON { (blsResponse) in
            if let JSON = blsResponse.result.value {
                guard
                    let careerResults = JSON as? NSDictionary
                    else {
                        print("There was a problem pulling the Career Results from BLS.")
                        return
                }
                
                guard
                    let seriesValue = careerResults["series"] as? [NSDictionary] else {
                        return
                }
                let specificCareerInfo = seriesValue[0]
                guard
                    let specificCareerDictionary = specificCareerInfo["catalog"] as? NSDictionary,
                    let careerName = specificCareerDictionary["occupation"] else {
                        return
                }
                
                print("This is my career name: \(careerName)")
                completion(careerResults)
            }
        }
        
    }
}