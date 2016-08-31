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
        
        guard let url = NSURL(string: Secrets.apiURL) else {
            fatalError("There was an issue unwrapping the NSURL")
        }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var err: NSError?
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: []) as NSData
            
        } catch {
            
            if let err = err as NSError? {
                print("There's been an error adding the parameters to the request: \(err.localizedDescription)")
            }
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let data = data {
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
                    
                    if let json = json {
                        
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(json, nil)
                        })
                    }
                    
                } catch {
                    print("There was a problem getting the JSON in dataTaskWithRequest")
                }
            } else {
                if let error = error {
                    
                    print("There's been an error trying to get the JSON: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    class func getLocationQuotientforJobWithCompletion(params: [String : AnyObject], completion: (NSDictionary?, NSError?)->()) {
        
        guard let url = NSURL(string: Secrets.apiURL) else {
            fatalError("There was an issue unwrapping the NSURL")
        }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var err: NSError?
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: []) as NSData
            
        } catch {
            
            if let err = err as NSError? {
                print("There's been an error adding the parameters to the request: \(err.localizedDescription)")
            }
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let data = data {
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
                    
                    if let json = json {
                        
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(json, nil)
                        })
                    }
                    
                } catch {
                    print("There was a problem getting the JSON in dataTaskWithRequest")
                }
                
            } else {
                
                if let error = error {
                    
                    print("There's been an error trying to get the JSON: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    //        class func getMultipleOccupationsWithCompletion(params: [String: AnyObject], completion: (NSDictionary?, NSError?) -> ()) {
    //
    //            Alamofire.request(.POST, Secrets.apiURL, parameters: params, encoding: .JSON, headers: headers).responseJSON { (blsResponse) in
    //
    //                if let error = blsResponse.result.error {
    //                    print("There was an error pulling multiple occupations from the API: \(error.localizedDescription)")
    //                    completion(nil, error)
    //                }
    //
    //                if let json = blsResponse.result.value {
    //                    if let careerResults = json as? NSDictionary {
    //                        completion(careerResults, nil)
    //                    }
    //
    //                }
    //            }
    //        }
    //
    //        class func getLocationQuotientforJobWithCompletion(params: [String : AnyObject], completion: (NSDictionary?, NSError?)->()) {
    //
    //            Alamofire.request(.POST, Secrets.apiURL, parameters: params, encoding: .JSON, headers: headers).responseJSON { (blsLQresponse) in
    //                if let error = blsLQresponse.result.error {
    //                    print("There was an error pulling the Location Quotient from the API: \(error.localizedDescription)")
    //                    completion(nil, error)
    //                }
    //
    //                if let json = blsLQresponse.result.value {
    //                    if let lqResults = json as? NSDictionary  {
    //
    //                        completion(lqResults, nil)
    //                    }
    //                }
    //            }
    //        }
}