//
//  DataStore.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class DataStore {
    
    static let store = DataStore()
 
    var tpUser : TPUser?
    
    private init() { }
}