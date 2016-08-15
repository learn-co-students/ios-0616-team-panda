//
//  BLSAPIClient.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BLSAPIClient {
    
    class func getMultipleOccupationsWithCompletion(params: [String: AnyObject], completion: (NSDictionary) -> ()) {
        
        let header = [
            "Content-Type" : "application/json",
            ]
        
        Alamofire.request(.POST, Secrets().apiURL, parameters: params, encoding: .JSON, headers: header).responseJSON { (blsResponse) in
            if let json = blsResponse.result.value {
                guard
                    let careerResults = json as? NSDictionary
                    else {
                        print("There was a problem pulling the Career Results from BLS.")
                        return
                }
                completion(careerResults)
            }
        }
    }
}