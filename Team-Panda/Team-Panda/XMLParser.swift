//
//  XMLParser.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

//import Foundation
//import SWXMLHash
//
//class XMLParser: NSObject, XMLParserDelegate {
//    
//    var occupationalData: [String: [String : String]] = [:]
//    
//    func parsingXML() {
//        
//        guard
//            let xmlURL = URL(string: "http://www.bls.gov/ooh/xml-compilation.xml"),
//            let xmlData = try? Data(contentsOf: xmlURL) else {
//                print("There was an issue with pulling data from the XML URL")
//                return
//        }
//        
//        let xml = SWXMLHash.parse(xmlData)
//        
//        var i = 0
//        while i < xml["ooh"]["occupation"].all.count {
//            
//            let occupationIndex = xml["ooh"]["occupation"][i]
//            guard
//                let occupationTitle = occupationIndex["title"].element?.text,
//                let occupationDescription = occupationIndex["description"].element?.text,
//                let howToBecomeOne = occupationIndex["how_to_become_one"]["section_body"].element?.text,
//                let minEducation = occupationIndex["quick_facts"]["qf_entry_level_education"]["value"].element?.text else {
//                    print("There was a problem unwrapping one of the elements in the XML: \(occupationIndex["title"].element?.text), \(occupationIndex["description"].element?.text), \(occupationIndex["how_to_become_one"]["section_body"].element?.text), \(occupationIndex["quick_facts"]["qf_entry_level_education"]["value"].element?.text)")
//                    return
//            }
//            
//            let dataForOccupation = [
//                "Title"                          : occupationTitle      ,
//                "Description"                    : occupationDescription,
//                "Minimum Education Requirements" : minEducation         ,
//                "How to Become One"              : howToBecomeOne       ,
//                ]
//            
//            var j = 0
//            while j < occupationIndex["soc_coverage"]["soc_code"].all.count {
//                
//                if let code = occupationIndex["soc_coverage"]["soc_code"][j].element?.text {
//                    self.occupationalData[code] = dataForOccupation
//                } else {
//                    print("Couldn't unwrap SOC Code: \(occupationIndex["soc_coverage"]["soc_code"][j].element?.text)")
//                }
//                j += 1
//            }
//            i += 1
//        }
//    }
//}
