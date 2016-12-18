//
//  USStatesColorMap.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 12/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

let statesLetterString = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyI"

private class USStatesColorMap {
    
    var controlInitialized: Bool
    var updateMode: Bool
    let statesFont: UIFont
    var colors: [String: Any]
    let statesNames: [String: Any]
    let statesCodes: [String: String]
    
    init() {
        
    }
    
    convenience init(with frame: CGRect) {
        if self = super.init(with: frame) {
            self.init()
        }
        return self
    }
    
    convenience init(with aDecoder: NSCoder) {
        if self = super.init(with: aDecoder) {
            self.init()
        }
        return self
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
        assert(color != nil, "Color can't be nil")
        colors.replaceObject(at: state, with: color)
        
        if !updateMode {
            self.setNeedsDisplay()
        }
    }
    
    func setColor(byCode stateCode: String) {
        assert(color != nil, "Color can't be nil")
        colors.replaceObject(at: self.indexForStateCode(stateCode), with: color)
        if !updateMode {
            self.setNeedsDipslay()
        }
    }
    
    func setColor(byName stateName: String) {
    
        assert(color != nil, "Color can't be nil")
        colors.replaceObject(at: self.indexForStateName(stateName), with: color)
        if !updateMode {
            self.setNeedsDisplay()
        }
    }
    
    func performUpdates(updatesBlock: UpdatesBlock) {
        self.beginUpdates
        updatesBlock()
        self.endUpdates
    }
}

private class USStatesColorMap {
    
    init() {
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
    }
}

