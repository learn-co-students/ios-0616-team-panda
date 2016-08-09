//
//  WouldYouRatherViewController.swift
//  
//
//  Created by Salmaan Rizvi on 8/8/16.
//
//

import Foundation
import UIKit
import ChameleonFramework
import SwiftFontName
import SwiftyButton

enum WouldYouRatherStyle {
    case Make
    case Think
    case Unknown
}

class WouldYouRatherViewController : UIViewController {
    
    // UI Properties
    let uiStyle : WouldYouRatherStyle
    
    var titleTextLabel : UILabel!
    var curiosityTextLabel : UILabel!
    var topButton : SwiftyButton!
    var bottomButton : SwiftyButton!
    
    init(withUIStyle uiStyle : WouldYouRatherStyle) {
        self.uiStyle = uiStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.uiStyle = .Unknown
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createStandardViews()
    }
    
    /* 
     *  Sets up all the UI buttons and labels with formatting and constraints
     */
    private func createStandardViews() {
        
        self.titleTextLabel = UILabel()

        self.titleTextLabel.text = "Tell us a little about yourself"
        self.titleTextLabel.font = UIFont.pandaFontLight(withSize: 72.0)
        self.titleTextLabel.adjustsFontSizeToFitWidth = true
        self.titleTextLabel.numberOfLines = 2
        self.titleTextLabel.textColor = FlatWhite()
        self.titleTextLabel.textAlignment = .Center
        
        self.view.addSubview(titleTextLabel)
        
        self.titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.titleTextLabel.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.titleTextLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.titleTextLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.5).active = true
        
        
        
        self.curiosityTextLabel = UILabel()
        
        self.curiosityTextLabel.text = "Would you rather..."
        self.curiosityTextLabel.font = UIFont.pandaFontLight(withSize: 25.0)
        self.curiosityTextLabel.numberOfLines = 1
        self.curiosityTextLabel.adjustsFontSizeToFitWidth = true
        self.curiosityTextLabel.textColor = FlatWhite()
        self.curiosityTextLabel.textAlignment = .Center
        
        self.view.addSubview(self.curiosityTextLabel)
        
        self.curiosityTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.curiosityTextLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.curiosityTextLabel.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.curiosityTextLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.curiosityTextLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.25).active = true
        
        
        
        self.topButton = SwiftyButton()

        self.view.addSubview(self.topButton)
        self.topButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.topButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.topButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: self.view.bounds.height/6).active = true
        self.topButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.topButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true

        
        
        self.bottomButton = SwiftyButton()
        
        self.view.addSubview(self.bottomButton)
        self.bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomButton.translatesAutoresizingMaskIntoConstraints = false
        self.bottomButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.bottomButton.centerYAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -self.view.bounds.height/6).active = true
        self.bottomButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.bottomButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
        
        self.createViewsForStyle(self.uiStyle)
    }
    
    /*
     *  Setup based on style of view controller designated at initialization
     */
    private func createViewsForStyle(style : WouldYouRatherStyle) {
        
        if self.uiStyle == .Make {
            
            self.view.backgroundColor = FlatYellow().lightenByPercentage(0.25)
            self.topButton.setTitle("Solve the problem at hand?", forState: .Normal)
            self.bottomButton.setTitle("Understand why the problem occured?", forState: .Normal)

        }
        else { // how people think
            
            self.view.backgroundColor = FlatMint()
            self.topButton.setTitle("Understand how ideas \nare expressed?", forState: .Normal)
            self.bottomButton.setTitle("Understand how ideas \nare formed?", forState: .Normal)
        }

        
        // First button setup
        self.topButton.buttonColor = FlatGreen()
        self.topButton.titleLabel?.textColor = ContrastColorOf(self.topButton.buttonColor, returnFlat: true)
        self.topButton.titleLabel?.numberOfLines = 2
        self.topButton.titleLabel?.textAlignment = .Center
        self.topButton.shadowColor = FlatGreenDark()
        self.topButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.topButton.shadowHeight = 5
        self.topButton.buttonPressDepth = 0.65
        self.topButton.cornerRadius = 5
        
        // Second button setup
        self.bottomButton.buttonColor = FlatSkyBlue()
        self.bottomButton.titleLabel?.textColor = FlatSkyBlueDark()
        self.bottomButton.titleLabel?.numberOfLines = 2
        self.bottomButton.titleLabel?.textAlignment = .Center
        self.bottomButton.shadowColor = self.bottomButton.buttonColor.darkenByPercentage(0.2)
        self.bottomButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.bottomButton.shadowHeight = 5
        self.bottomButton.buttonPressDepth = 0.65
        self.bottomButton.cornerRadius = 5
    }
}
