 //
 //  BLSAPIClient.swift
 //  Team-Panda
 //
 //  Created by Lloyd W. Sykes on 8/11/16.
 //  Copyright © 2016 Flatiron School. All rights reserved.
 //
 
 struct BLSAPIClient {
    
    static let headers = [ "Content-Type" : "application/json" ]
    
    static func getMultipleOccupationsWithCompletion(_ params: [String: Any], completion: @escaping (NSDictionary?, Error?) -> ()) {
        guard let url = URL(string: Secrets.apiURL) else {
            // TODO: Error Handle
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                // TODO: Error Handle
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(json, nil)
            }
        })
        task.resume()
    }
    
    static func getLocationQuotientforJobWithCompletion(_ params: [String : Any], completion: @escaping (NSDictionary?, Error?)->()) {
        guard let url = URL(string: Secrets.apiURL) else {
            // TODO: Error Handle
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) as Data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                DispatchQueue.main.async {
                    // TODO: Error Handle
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(json, nil)
            }
        }
        task.resume()
    }
    
    
 }
