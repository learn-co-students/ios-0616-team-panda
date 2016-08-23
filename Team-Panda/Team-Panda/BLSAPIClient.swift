//
//  BLSAPIClient.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Alamofire

class BLSAPIClient {
    
    static let headers = [ "Content-Type" : "application/json" ]
    
    class func getMultipleOccupationsWithCompletion(params: [String: AnyObject], completion: (NSDictionary?, NSError?) -> ()) {
        
        Alamofire.request(.POST, Secrets.apiURL, parameters: params, encoding: .JSON, headers: headers).responseJSON { (blsResponse) in
            if let error = blsResponse.result.error {
                completion(nil, error)
            }
            
            if let json = blsResponse.result.value {
                guard let careerResults = json as? NSDictionary else {
                    return
                }
                completion(careerResults, nil)
            }
        }
    }
    
    class func getLocationQuotientforJobWithCompletion(params: [String : AnyObject], completion: (NSDictionary?, NSError?)->()) {
        
        Alamofire.request(.POST, Secrets.apiURL, parameters: params, encoding: .JSON, headers: headers).responseJSON { (blsLQresponse) in
            if let error = blsLQresponse.result.error {
                completion(nil, error)
            }
            if let json = blsLQresponse.result.value {
                guard let lqResults = json as? NSDictionary else {
                    return
                }
                completion(lqResults, nil)
            }
        }
    }
}