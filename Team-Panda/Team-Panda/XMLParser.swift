//
//  XMLParser.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import SWXMLHash

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var occupationalData: [String: [String : String]] = [:]
    
    func parsingXML() {
        guard
            let xmlURL = NSURL(string: "http://www.bls.gov/ooh/xml-compilation.xml"),
            let xmlData = NSData(contentsOfURL: xmlURL) else {
                print("There was an issue with pulling data from the XML URL")
                return
        }
        
        let xml = SWXMLHash.parse(xmlData)
        
        print(xml["ooh"]["occupation"].all.count)
        
        var i = 0
        
        while i < xml["ooh"]["occupation"].all.count {
            
            let occupationIndex = xml["ooh"]["occupation"][i]
            
            guard
                let occupationTitle = occupationIndex["title"].element?.text,
                let occupationDescription = occupationIndex["description"].element?.text,
                let howToBecomeOne = occupationIndex["how_to_become_one"]["section_body"].element?.text,
                let minEducation = occupationIndex["quick_facts"]["qf_entry_level_education"]["value"].element?.text else {
                    print("There was a problem unwrapping one of the elements in the XML: \(occupationIndex["title"].element?.text), \(occupationIndex["description"].element?.text), \(occupationIndex["how_to_become_one"]["section_body"].element?.text), \(occupationIndex["quick_facts"]["qf_entry_level_education"]["value"].element?.text)")
                    return
            }
            print("These are the minimum educational requirements by occupation:  \(minEducation)")
            let dataForOccupation = [
                "Title"                          : occupationTitle      ,
                "Description"                    : occupationDescription,
                "Minimum Education Requirements" : minEducation         ,
                "How to Become One"              : howToBecomeOne       ,
                ]
            
            var j = 0
            
            while j < occupationIndex["soc_coverage"]["soc_code"].all.count {
                
                if let code = occupationIndex["soc_coverage"]["soc_code"][j].element?.text {
                    
                    self.occupationalData[code] = dataForOccupation
                    
                } else {
                    
                    print("Couldn't unwrap SOC Code: \(occupationIndex["soc_coverage"]["soc_code"][j].element?.text)")
                    
                }
                j += 1
            }
            i += 1
        //        print("This is my occupationalData dictionary sorted by SOC Code: \(self.occupationalData)")
        }
    }
}