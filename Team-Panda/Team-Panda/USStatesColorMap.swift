//
//  USStatesColorMap.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import CoreText

let statesLetterString = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyI"
var UpdatesBlock: Void? = nil

private class USStatesColorMap: UIView {
    
    var controlInitialized: Bool
    var updateMode: Bool
    var statesFont: UIFont
    var colors: [Any]
    let statesNames: [String: USStates]
    let statesCodes: [String: USStates]
    
    init() {
          }
    
    convenience init(with frame: CGRect) {
        self.init()
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    func setColorForAllStates(color: UIColor) {
        colors.removeAll()
        
        for i in 0..<statesLetterString.characters.count {
            colors.append(color)
        }
        if !updateMode {
            self.setNeedsDisplay()
        }
    }
    
    func setColor(forState state: USStates) {
        colors.replaceObject(at: state, with: color)
        
        if !updateMode {
            self.setNeedsDisplay()
        }
    }
    
    func setColor(byCode stateCode: String) {
        colors.replaceObject(at: self.indexForStateCode(stateCode), with: color)
        if !updateMode {
            self.setNeedsDisplay()
        }
    }
    
    func setColor(byName stateName: String) {
        colors.replaceObject(at: self.indexForStateName(stateName), with: color)
        if !updateMode {
            self.setNeedsDisplay()
        }
    }
    
    func performUpdates(updatesBlock: UpdatesBlock) {
        self.beginUpdates()
        updatesBlock()
        self.endUpdates()
    }
}

extension USStatesColorMap {
    
  convenience init() {
        var colors = [String : Any]
        
        for i in 0..<statesLetterString.characters.count {
            colors.append(UIColor.black)
        }
        
        if !self.isStatelyRegistered {
            self.registerStatelyFont
        }
        
        statesNames = ["Alabama"              : Alabama         ,
                       "Alaska"               : Alaska          ,
                       "Arkansas"             : Arkansas        ,
                       "Arizona"              : Arizona         ,
                       "California"           : California      ,
                       "Colorado"             : Colorado        ,
                       "Connecticut"          : Connecticut     ,
                       "Delaware"             : Delaware        ,
                       "Florida"              : Florida         ,
                       "Georgia"              : Georgia         ,
                       "Hawaii"               : Hawaii          ,
                       "Idaho"                : Idaho           ,
                       "Illinois"             : Illinois        ,
                       "Indiana"              : Indiana         ,
                       "Iowa"                 : Iowa            ,
                       "Kansas"               : Kansas          ,
                       "Kentucky"             : Kentucky        ,
                       "Louisiana"            : Louisiana       ,
                       "Maine"                : Maine           ,
                       "Maryland"             : Maryland        ,
                       "Massachusetts"        : Massachusetts   ,
                       "Michigan"             : Michigan        ,
                       "Minnesota"            : Minnesota       ,
                       "Mississippi"          : Mississippi     ,
                       "Missouri"             : Missouri        ,
                       "Montana"              : Montana         ,
                       "Nebraska"             : Nebraska        ,
                       "Nevada"               : Nevada          ,
                       "New Hampshire"        : NewHampshire    ,
                       "New Jersey"           : NewJersey       ,
                       "New Mexico"           : NewMexico       ,
                       "New York"             : NewYork         ,
                       "North Carolina"       : NorthCarolina   ,
                       "North Dakota"         : NorthDakota     ,
                       "Ohio"                 : Ohio            ,
                       "Oklahoma"             : Oklahoma        ,
                       "Oregon"               : Oregon          ,
                       "Pennsylvania"         : Pennsylvania    ,
                       "Rhode Island"         : RhodeIsland     ,
                       "South Carolina"       : SouthCarolina   ,
                       "South Dakota"         : SouthDakota     ,
                       "Tennessee"            : Tennessee       ,
                       "Texas"                : Texas           ,
                       "Utah"                 : Utah            ,
                       "Virginia"             : Virginia        ,
                       "Vermont"              : Vermont         ,
                       "Washington"           : Washington      ,
                       "West Virginia"        : WestVirginia    ,
                       "Wisconsin"            : Wisconsin       ,
                       "Wyoming"              : Wyoming         ,
                       "District of Columbia" : DistrictOfColumbia]
        
        statesCodes = ["AL": Alabama        ,
                       "AK": Alaska         ,
                       "AR": Arkansas       ,
                       "AZ": Arizona        ,
                       "CA": California     ,
                       "CO": Colorado       ,
                       "CT": Connecticut    ,
                       "DE": Delaware       ,
                       "FL": Florida        ,
                       "GA": Georgia        ,
                       "HI": Hawaii         ,
                       "ID": Idaho          ,
                       "IL": Illinois       ,
                       "IN": Indiana        ,
                       "IA": Iowa           ,
                       "KS": Kansas         ,
                       "KY": Kentucky       ,
                       "LA": Louisiana      ,
                       "ME": Maine          ,
                       "MD": Maryland       ,
                       "MA": Massachusetts  ,
                       "MI": Michigan       ,
                       "MN": Minnesota      ,
                       "MS": Mississippi    ,
                       "MO": Missouri       ,
                       "MT": Montana        ,
                       "NE": Nebraska       ,
                       "NV": Nevada         ,
                       "NH": NewHampshire   ,
                       "NJ": NewJersey      ,
                       "NM": NewMexico      ,
                       "NY": NewYork        ,
                       "NC": NorthCarolina  ,
                       "ND": NorthDakota    ,
                       "OH": Ohio           ,
                       "OK": Oklahoma       ,
                       "OR": Oregon         ,
                       "PA": Pennsylvania   ,
                       "RI": RhodeIsland    ,
                       "SC": SouthCarolina  ,
                       "SD": SouthDakota    ,
                       "TN": Tennessee      ,
                       "TX": Texas          ,
                       "UT": Utah           ,
                       "VA": Virginia       ,
                       "VT": Vermont        ,
                       "WA": Washington     ,
                       "WV": WestVirginia   ,
                       "WI": Wisconsin      ,
                       "WY": Wyoming        ,
                       "DC": DistrictOfColumbia
        ]
        
        controlInitialized = true
        self.setNeedsDisplay()
    }
    
    func isStatelyFontRegistered() -> Bool {
        for font in UIFont.fontNames(forFamilyName: "Stately") {
            if font == "font3933" {
                return true
            }
        }
        return false
    }
    
    func registerStatelyFont() {
        
        let fontDataProvider: CGDataProvider = CGDataProvider(filename: NSUTF8StringEncoding(Bundle.main.path(forResource: "stately", ofType: "ttf")))
        
        let statelyFontRef: CGFont = CGFont(fontDataProvider)
        CGDataProviderReleaseDataCallback(fontDataProvider)
        
        let error: CFError? = nil
        CTFontManagerRegisterGraphicsFont(statelyFontRef, &error)
        
        CGDataProviderReleaseDataCallback(statelyFontRef)
        
        if error != nil {
            let err = error as! Error
            print("There was an error registerStatelyFont: \(err.localizedDescription)")
        }
        
    }
    
    func getStatelyFont() -> UIFont {
        return UIFont(name: "font3933", size: self.bounds.size.width)!
    }
    
    func index(for stateCode: String) -> Int {
        let stateCodeUpper = stateCode.uppercased()
        let stateIndex = statesCodes[stateCodeUpper]
        
        return Int(stateIndex)!
    }
    
    func index(for stateName: String) -> Int {
        let stateIndex = statesNames[stateName]
        
        return Int(stateIndex)!
    }
    
    func beginUpdates() {
        updateMode = true
    }
    
    func endUpdates() {
        updateMode = false
        self.setNeedsDisplay()
    }
    
    func drawRect(rect: CGRect) {
        super.draw(rect)
        statesFont = getStatelyFont()
        
        if controlInitialized {
            let context: CGContext = UIGraphicsGetCurrentContext()!
            for i in 0..<statesLetterString.characters.count {
                CGContext( CGColor(colorSpace: context as! CGColorSpace, components: colors[i] as! UnsafePointer<CGFloat>))
                (statesLetterString.substring(with: NSMakeRange(i, 1)).draw(atPoint: CGPointZero, withFont: statesFont))
            }
        }
    }
}

