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
    
    
    var delegate: NSXMLParserDelegate!
    var parser: NSXMLParser!
    var dataItems = []
    
    
    override init() {
        
    }
    
    class func playingWithSWMXMLHash() {
        guard
            let xmlURL = NSURL(string: "http://www.bls.gov/ooh/xml-compilation.xml"),
            let xmlData = NSData(contentsOfURL: xmlURL) else {
                return
        }
        
        let xml = SWXMLHash.config {
            config in
            config.shouldProcessLazily = true
            }.parse(xmlData)
        
        
        for occupation in xml["ooh"]["occupation"] {
            guard
                let occupationTitle = occupation["title"].element?.text,
                let occupationDescription = occupation["description"].element?.text,
                let howToBecomeOne = occupation["how_to_become_one"]["section_body"].element?.text else {
                    return
            }
            
            print("This is the occupation data: \(occupationTitle), \(occupationDescription), \(howToBecomeOne)")
        }
        
        
        // print("Value for XML file in XMLParser: \(xml["ooh"]["occupation"]["how_to_become_one"].element?.text)")
        
    }
    
    
    func returnedDataItems(data: [AnyObject]) {
        
    }
    
    func getDataItemsFromXML(filename: String) {
        
        
    }
    
    func parseXML(filename: String) {
        
    }
    
    
    /*
     SETTING UP XML FILE TO BE PARSED
     */
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}