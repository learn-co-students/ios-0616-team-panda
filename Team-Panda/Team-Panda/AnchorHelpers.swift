//
//  Anchors.swift
//  Team-Panda
//
//  Created by Lloyd Sykes on 2/6/18.
//  Copyright © 2018 Flatiron School. All rights reserved.
//

import Foundation

extension UIView {
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        else {
            return leadingAnchor
        }
    }
    
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        else {
            return trailingAnchor
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        else {
            return topAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        else {
            return bottomAnchor
        }
    }
    
    var safeCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.centerXAnchor
        }
        else {
            return centerXAnchor
        }
    }
    
    var safeCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.centerYAnchor
        }
        else {
            return centerYAnchor
        }
    }
    
    var safeWidthAnchor: NSLayoutDimension {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.widthAnchor
        }
        else {
            return widthAnchor
        }
    }
    
    var safeHeightAnchor: NSLayoutDimension {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.heightAnchor
        }
        else {
            return heightAnchor
        }
    }
}
