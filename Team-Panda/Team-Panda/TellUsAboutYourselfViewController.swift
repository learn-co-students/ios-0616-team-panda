//
//  TellUsAboutYourselfViewController.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import SwiftFontName
import SwiftyButton

class TellUsAboutYourselfViewController : UIViewController {
    
    var titleTextLabel : UILabel!
    var curiousityTextLabel : UILabel!
    var makingButton : SwiftyButton!
    var thinkingButton : SwiftyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = FlatBlueDark()
        self.createViews()
    }
    
    func buttonTapped(sender : SwiftyButton) {
        
        if let signUpVC = self.parentViewController as? SignUpPageViewController {
            
            if sender == self.makingButton {
            
                signUpVC.nextViewController(.Make)
            }
            else { // thinking button called function
                signUpVC.nextViewController(.Think)
            }
        }
    }
    
    private func createViews() {
        
        self.titleTextLabel = UILabel()
        
        self.titleTextLabel.text = "Tell us a little about yourself!"
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
        
        
        self.curiousityTextLabel = UILabel()
        
        self.curiousityTextLabel.text = "Are you more curious about..."
        self.curiousityTextLabel.font = UIFont.pandaFontLight(withSize: 35)
        self.curiousityTextLabel.numberOfLines = 1
        self.curiousityTextLabel.adjustsFontSizeToFitWidth = true
        self.curiousityTextLabel.textColor = FlatWhite()
        self.curiousityTextLabel.textAlignment = .Center
        
        self.view.addSubview(self.curiousityTextLabel)
        
        self.curiousityTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.curiousityTextLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.curiousityTextLabel.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.curiousityTextLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.curiousityTextLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.25).active = true
        
        
        self.makingButton = SwiftyButton()
        
        self.makingButton.setTitle("How things are made", forState: .Normal)
        self.makingButton.titleLabel?.textColor = FlatWhite()
        self.makingButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.makingButton.buttonColor = FlatMint()
        self.makingButton.highlightedColor = FlatMintDark()
        self.makingButton.shadowColor = FlatMintDark()
        self.makingButton.shadowHeight = 5
        self.makingButton.buttonPressDepth = 0.65
        self.makingButton.cornerRadius = 5
        
        self.makingButton.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.makingButton)
        
        self.makingButton.translatesAutoresizingMaskIntoConstraints = false
        self.makingButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.makingButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: self.view.bounds.height/6).active = true
        self.makingButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.makingButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
        
        
        self.thinkingButton = SwiftyButton()
        
        self.thinkingButton.setTitle("How people think", forState: .Normal)
        self.thinkingButton.titleLabel?.textColor = FlatWhite()
        self.thinkingButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.thinkingButton.buttonColor = FlatMintDark().darkenByPercentage(0.1)
        self.thinkingButton.highlightedColor = FlatMintDark().darkenByPercentage(0.2)
        self.thinkingButton.shadowColor = FlatMintDark().darkenByPercentage(0.2)
        self.thinkingButton.shadowHeight = 5
        self.thinkingButton.buttonPressDepth = 0.65
        self.thinkingButton.cornerRadius = 5
        
        self.thinkingButton.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.thinkingButton)
        
        self.thinkingButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.thinkingButton.translatesAutoresizingMaskIntoConstraints = false
        self.thinkingButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.thinkingButton.centerYAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -self.view.bounds.height/6).active = true
        self.thinkingButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.thinkingButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
    }
}
