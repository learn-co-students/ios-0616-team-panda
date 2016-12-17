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
    var makingButton : PressableButton!
    var thinkingButton : PressableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = FlatBlueDark()
        self.createViews()
    }
    
    override var shouldAutorotate : Bool { return false }
    
    func buttonTapped(_ sender : PressableButton) {
        
        if let signUpVC = self.parent as? SignUpPageViewController {
            
            if sender == self.makingButton {
                
                signUpVC.nextViewController(.Make)
            }
            else { // thinking button called function
                signUpVC.nextViewController(.Think)
            }
        }
    }
    
    fileprivate func createViews() {
        
        self.titleTextLabel = UILabel()
        
        self.titleTextLabel.text = "Tell us a little about yourself!"
        self.titleTextLabel.font = UIFont.pandaFontLight(withSize: 72.0)
        self.titleTextLabel.adjustsFontSizeToFitWidth = true
        self.titleTextLabel.numberOfLines = 2
        self.titleTextLabel.textColor = FlatWhite()
        self.titleTextLabel.textAlignment = .center
        
        self.view.addSubview(titleTextLabel)
        
        self.titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.titleTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.titleTextLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        self.curiousityTextLabel = UILabel()
        
        self.curiousityTextLabel.text = "Are you more curious about..."
        self.curiousityTextLabel.font = UIFont.pandaFontLight(withSize: 35)
        self.curiousityTextLabel.numberOfLines = 1
        self.curiousityTextLabel.adjustsFontSizeToFitWidth = true
        self.curiousityTextLabel.textColor = FlatWhite()
        self.curiousityTextLabel.textAlignment = .center
        
        self.view.addSubview(self.curiousityTextLabel)
        
        self.curiousityTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.curiousityTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.curiousityTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.curiousityTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.curiousityTextLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        self.makingButton = PressableButton()
        
        self.makingButton.setTitle("How things are made", for: .normal)
        self.makingButton.titleLabel?.textColor = FlatWhite()
        self.makingButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.makingButton.colors = .init(button: FlatMint(), shadow: FlatMintDark())

        self.makingButton.shadowHeight = 5
        self.makingButton.depth = 0.65
        self.makingButton.cornerRadius = 5
        
        self.makingButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(self.makingButton)
        
        self.makingButton.translatesAutoresizingMaskIntoConstraints = false
        self.makingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.makingButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.height/6).isActive = true
        self.makingButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.makingButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
        
        self.thinkingButton = PressableButton()
        
        self.thinkingButton.setTitle("How people think", for: .normal)
        self.thinkingButton.titleLabel?.textColor = FlatWhite()
        self.thinkingButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.thinkingButton.colors = .init(button: FlatMintDark().darken(byPercentage: 0.1), shadow: FlatMintDark().darken(byPercentage: 0.2))
        self.thinkingButton.shadowHeight = 5
        self.thinkingButton.depth = 0.65
        self.thinkingButton.cornerRadius = 5
        
        self.thinkingButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(self.thinkingButton)
        
        self.thinkingButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.thinkingButton.translatesAutoresizingMaskIntoConstraints = false
        self.thinkingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.thinkingButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.bounds.height/6).isActive = true
        self.thinkingButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.thinkingButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
    }
}
