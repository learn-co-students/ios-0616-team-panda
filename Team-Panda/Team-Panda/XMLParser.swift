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
        let xml = SWXMLHash.config {
            config in
            config.shouldProcessLazily = true
            }.parse((NSBundle.mainBundle().resourcePath?.stringByAppendingString("xml-compilation.xml"))!)
        
        guard let occupationName = xml["ooh"]["occupation"]["title"].element?.text else {
            return
        }
        
        if occupationName == "Accountants and Auditors" {
            
            print("Value for XML file in XMLParser: \(xml["ooh"]["occupation"]["how_to_become_one"].element?.text)")
            
        }
        
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