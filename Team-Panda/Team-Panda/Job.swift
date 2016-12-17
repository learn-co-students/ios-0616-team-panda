//
//  Jobs.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class Job : CustomStringConvertible {
    
    let occupation : String
    let seriesID : String
    let annualMeanSalary : String
    let SOCcode : String
    let dataYear : String
    
    var locationQuotient : [String : Double]
    var jobDescription : String
    var minEduReq : String
    var howToBecome : String
    
    var dashSOCcode : String {
        
        var dashCode = self.SOCcode
        dashCode.insert("-", at: dashCode.characters.index(dashCode.startIndex, offsetBy: 2))
        return dashCode
    
    }
    
    init(withDictionary dictionary : [String : Any]) {
        
        if let catalogData = dictionary["catalog"] as? [String : String] {
            
            self.occupation = Job.trim(catalogData["occupation"] ?? "")
            self.seriesID = catalogData["series_id"] ?? ""
            let firstSOCCodeParse = self.seriesID.replacingOccurrences(of: "OEUN0000000000000", with: "")
            self.SOCcode = firstSOCCodeParse.substring(to: firstSOCCodeParse.characters.index(firstSOCCodeParse.startIndex, offsetBy: 6))
            
        } else {
            print("Couldn't parse catalog data from input dictionary")
            self.occupation = ""
            self.seriesID = ""
            self.SOCcode = ""
        }
        
        if let measurementData = dictionary["data"] as? [[String : Any]] {
            
            self.dataYear = measurementData[0]["year"] as? String ?? ""
            self.annualMeanSalary = measurementData[0]["value"] as? String ?? ""
            
        } else {
            self.dataYear = ""
            self.annualMeanSalary = ""
        }
        
        self.locationQuotient = [:]
        self.jobDescription = ""
        self.minEduReq = ""
        self.howToBecome = ""
    }
    
    convenience init(withSOCCode socCode : String, occupation : String) {
        let seriesID = "OEUN0000000000000" + socCode
        let dictionary : [String : Any] = ["catalog": ["occupation" : occupation, "series_id" : seriesID]]
        self.init(withDictionary: dictionary)
    }
    
    var description: String {
        return "Occupation: \(self.occupation)\n"
        + "Annual Mean Salary: \(self.annualMeanSalary)\n"
        + "Data from: \(self.dataYear)\n"
        + "Series ID: \(self.seriesID)\n"
        + "SOC Code: \(self.SOCcode)\n"
        + "SOC Dash Code: \(self.dashSOCcode)\n"
        + "Location Quotient Dictionary: \(self.locationQuotient)\n"
    }
    
    func updateLocationQuotient(withDictionary dictionary : [String : Any]) {
        
        
        
    }
    
    class func trim(_ title : String) -> String {
        
        return title.components(separatedBy: ", ")[0]
        
    }
}
