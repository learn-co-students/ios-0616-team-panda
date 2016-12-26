 //
 //  BLSAPIClient.swift
 //  Team-Panda
 //
 //  Created by Lloyd W. Sykes on 8/11/16.
 //  Copyright © 2016 Flatiron School. All rights reserved.
 //
 
 import Alamofire
 
 struct BLSAPIClient {
    
    static let headers = [ "Content-Type" : "application/json" ]
    
//    static func getMultipleOccupationsWithCompletion(_ params: [String: Any], completion: @escaping (NSDictionary?, Error?) -> ()) {
//        
//        guard let url = URL(string: Secrets.apiURL) else {
//            fatalError("There was an issue unwrapping the NSURL")
//        }
//        
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        var err: NSError?
//        
//        do {
//            
//            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: []) as Data
//            
//        } catch {
//            
//            if let err = err as Error? {
//                print("There's been an error adding the parameters to the request: \(err.localizedDescription)")
//            }
//        }
//        
//        let session = URLSession.shared
//        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//            
//            if let data = data {
//                do {
//                    
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//                    
//                    if let json = json {
//                        
//                        OperationQueue.main.addOperation({
//                            completion(json, nil)
//                        })
//                    }
//                    
//                } catch {
//                    print("There was a problem getting the JSON in dataTaskWithRequest")
//                }
//            } else {
//                if let error = error {
//                    
//                    print("There's been an error trying to get the JSON: \(error.localizedDescription)")
//                    completion(nil, error)
//                }
//            }
//        }).resume()
//    }
//    
//    static func getLocationQuotientforJobWithCompletion(_ params: [String : Any], completion: @escaping (NSDictionary?, Error?)->()) {
//        
//        guard let url = URL(string: Secrets.apiURL) else {
//            fatalError("There was an issue unwrapping the NSURL")
//        }
//        
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        var err: NSError?
//        
//        do {
//            
//            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: []) as Data
//            
//        } catch {
//            
//            if let err = err as NSError? {
//                print("There's been an error adding the parameters to the request: \(err.localizedDescription)")
//            }
//        }
//        
//        let session = URLSession.shared
//        
//        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//            
//            if let data = data {
//                do {
//                    
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//                    
//                    if let json = json {
//                        
//                        OperationQueue.main.addOperation({
//                            completion(json, nil)
//                        })
//                    }
//                    
//                } catch {
//                    print("There was a problem getting the JSON in dataTaskWithRequest")
//                }
//                
//            } else {
//                
//                if let error = error {
//                    
//                    print("There's been an error trying to get the JSON: \(error.localizedDescription)")
//                    completion(nil, error)
//                }
//            }
//        }).resume()
//    }
//    
        static func getMultipleOccupationsWithCompletion(_ params: [String: Any], completion: @escaping (NSDictionary?, Error?) -> ()) {
    
            Alamofire.request(Secrets.apiURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                if let error = response.result.error {
                    completion(nil, error)
                } else if let json = response.result.value as? NSDictionary {
                    completion(json, nil)
                }
            }
    
    
        }
    
        static func getLocationQuotientforJobWithCompletion(_ params: [String : Any], completion: @escaping (NSDictionary?, Error?)->()) {
    
            Alamofire.request(Secrets.apiURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
    
                if let error = response.result.error {
                    completion(nil, error)
                } else if let json = response.result.value as? NSDictionary {
                    completion(json, nil)
                }
            }
            
        }
        
 }
