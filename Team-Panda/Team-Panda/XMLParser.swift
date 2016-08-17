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
                return
        }
        
        let xml = SWXMLHash.parse(xmlData)
        
        var i = 0
        while i < xml["ooh"]["occupation"].all.count {
            
            let occupationIndex = xml["ooh"]["occupation"][i]
            guard
                let occupationTitle = occupationIndex["title"].element?.text,
                let occupationDescription = occupationIndex["description"].element?.text,
                let howToBecomeOne = occupationIndex["how_to_become_one"]["section_body"].element?.text else {
                    return
            }
            
            let dataForOccupation = ["Title": occupationTitle,
                                     "Description" : occupationDescription,
                                     "How to Become One": howToBecomeOne,
                                     ]
            
            var j = 0
            while j < occupationIndex["soc_coverage"]["soc_code"].all.count {
                
                if let code = occupationIndex["soc_coverage"]["soc_code"][j].element?.text {
                    
                    self.occupationalData[code] = dataForOccupation
                    print("Occupational data dictionary: \(self.occupationalData)")
                    
                } else {
                    
                    print("There was an error unwrapping soc code at: \(j)")
                    
                }
                j += 1
            }
            i += 1
        }
    }
}