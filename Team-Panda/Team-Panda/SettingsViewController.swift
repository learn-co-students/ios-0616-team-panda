//
//  SettingsViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import SwiftFontName
import SwiftyButton

class SettingsViewController: UIViewController {

    var updateProfileButton     : SwiftyButton!
    var refreshQuestionsButton  : SwiftyButton!
    var logOutButton            : SwiftyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.flatSkyBlueColor()
        setupButtons()
    }
    
    func updateProfileTapped(sender : AnyObject) {
        print("Update Profile Info Tapped")
        self.presentViewController(UserProfileViewController(), animated: true, completion: nil)
    }
    
    func refreshQuestionaireTapped(sender : AnyObject) {
        print("Refresh Questionaire")
        self.presentViewController(SignUpPageViewController(), animated: true, completion: nil)
    }
    
    func logoutTapped(sender : AnyObject) {
        print("Log Out")
        
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?\nYour information will be saved if you log back in.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .Destructive, handler: { (alertAction) in
            
            do{
                try FIRAuth.auth()?.signOut()
            }  catch {fatalError("Unable to log user out")}
            self.presentViewController(LoginViewController(), animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (alertAction) in
            print("User didn't want to log out. Hide alert.")
        }))
        
        self.presentViewController(alert, animated: true, completion: {
            print("Finished presenting alert.")
        })
    }
    
    func setupButtons() {
        
        self.updateProfileButton = SwiftyButton()
        self.updateProfileButton.setTitleColor(FlatSkyBlueDark(), forState: .Normal)
        self.updateProfileButton.setTitle("Update Profile Info", forState: .Normal)
        self.updateProfileButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.updateProfileButton.buttonColor = FlatWhite()
        self.updateProfileButton.highlightedColor = FlatWhiteDark()
        self.updateProfileButton.shadowColor = FlatWhiteDark()
        self.updateProfileButton.shadowHeight = 5
        self.updateProfileButton.buttonPressDepth = 0.65
        self.updateProfileButton.cornerRadius = 5
        
        self.updateProfileButton.addTarget(self, action: #selector(updateProfileTapped(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.updateProfileButton)
        self.updateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.updateProfileButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.65).active = true
        self.updateProfileButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 1/6.0).active = true
        self.updateProfileButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.updateProfileButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: -self.view.bounds.height*1/4.0).active = true
        
        self.refreshQuestionsButton = SwiftyButton()
        self.refreshQuestionsButton.setTitleColor(FlatSkyBlueDark(), forState: .Normal)
        self.refreshQuestionsButton.setTitle("Refresh Questionaire", forState: .Normal)
        self.refreshQuestionsButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.refreshQuestionsButton.buttonColor = FlatWhite()
        self.refreshQuestionsButton.highlightedColor = FlatWhiteDark()
        self.refreshQuestionsButton.shadowColor = FlatWhiteDark()
        self.refreshQuestionsButton.shadowHeight = 5
        self.refreshQuestionsButton.buttonPressDepth = 0.65
        self.refreshQuestionsButton.cornerRadius = 5
        
        self.refreshQuestionsButton.addTarget(self, action: #selector(refreshQuestionaireTapped(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.refreshQuestionsButton)
        self.refreshQuestionsButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshQuestionsButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.65).active = true
        self.refreshQuestionsButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 1/6.0).active = true
        self.refreshQuestionsButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.refreshQuestionsButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: 0).active = true
        
        self.logOutButton = SwiftyButton()
        self.logOutButton.setTitleColor(FlatSkyBlueDark(), forState: .Normal)
        self.logOutButton.setTitle("Log Out", forState: .Normal)
        self.logOutButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.logOutButton.buttonColor = FlatWhite()
        self.logOutButton.highlightedColor = FlatWhiteDark()
        self.logOutButton.shadowColor = FlatWhiteDark()
        self.logOutButton.shadowHeight = 5
        self.logOutButton.buttonPressDepth = 0.65
        self.logOutButton.cornerRadius = 5
        
        self.logOutButton.addTarget(self, action: #selector(logoutTapped(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.logOutButton)
        self.logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.logOutButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.65).active = true
        self.logOutButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 1/6.0).active = true
        self.logOutButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.logOutButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: self.view.bounds.height*1/4.0).active = true
    }
    
}
