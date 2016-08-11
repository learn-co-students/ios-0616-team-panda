//
//  UserProfileViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
import SwiftyButton
import ChameleonFramework
import SwiftFontName

class UserProfileViewController: UIViewController {
    
    var email = UITextField()
    var password = UITextField()
    var updateYourInfo = UILabel()
    //var userAvatarImage = UIImageView()
    
    
    var saveChangesButton = SwiftyButton()
    var cancelButton = SwiftyButton()
    var resetPasswordButton = SwiftyButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleUserProfileViews()
        
    }
    
    @IBAction func saveChangesButtonTapped(sender: UIButton!) {
    let newEmail = self.email.text!
    DataStore.store.tpUser?.email = newEmail
    DataStore.store.tpUser?.updateUserProfile()
    print("TPUser email was updated to \(DataStore.store.tpUser?.email)")
    let alert = Constants.displayAlertWithTryAgain("Your email was saved as", message: "\(newEmail)")
    self.presentViewController(alert, animated: true, completion: nil)
    self.presentViewController(SettingsViewController(), animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(sender: UIButton!) {
        print("Cancel Button Tapped")
        self.presentViewController(SettingsViewController(), animated: true, completion: nil)
    }
    

    func createViews() {
        self.saveChangesButton.setTitle("Save Changes", forState: .Normal)
        self.saveChangesButton.addTarget(self, action: #selector(saveChangesButtonTapped), forControlEvents: .TouchUpInside)
        
        
        //Add SubViews
        self.view.addSubview(cancelButton)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(saveChangesButton)
        self.view.addSubview(updateYourInfo)
        //self.view.addSubview(userAvatarImage)
        //self.view.addSubview(resetPasswordButton)
        
        self.password.translatesAutoresizingMaskIntoConstraints=false
        self.email.translatesAutoresizingMaskIntoConstraints=false
        self.cancelButton.translatesAutoresizingMaskIntoConstraints=false
        self.saveChangesButton.translatesAutoresizingMaskIntoConstraints=false
        self.updateYourInfo.translatesAutoresizingMaskIntoConstraints = false
        //self.userAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        //self.resetPasswordButton.translatesAutoresizingMaskIntoConstraints=false
        
//        self.userAvatarImage.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active=true
//        self.userAvatarImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
//        self.userAvatarImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: self.view.bounds.height/18).active = true
        
        
        self.updateYourInfo.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.updateYourInfo.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.updateYourInfo.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.updateYourInfo.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.5).active = true
        
        self.cancelButton.setTitle("Cancel", forState: .Normal)
        self.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), forControlEvents: .TouchUpInside)
        
        self.password.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active=true
        self.password.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active=true
        self.password.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active=true
        self.password.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active=true
        
        self.email.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active=true
        self.email.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active=true
        self.email.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active=true
        self.email.bottomAnchor.constraintEqualToAnchor(self.password.topAnchor).active=true

        self.saveChangesButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.saveChangesButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: self.view.bounds.height/6).active = true
        self.saveChangesButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.saveChangesButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
        
        self.cancelButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.cancelButton.centerYAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -self.view.bounds.height/6).active = true
        self.cancelButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.cancelButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
    }
    
    func styleUserProfileViews() {
        
        self.view.backgroundColor = FlatWhite()
        
//        self.userAvatarImage.layer.cornerRadius = 50
//        self.userAvatarImage.backgroundColor = UIColor.flatOrangeColor()
        
        //Styling for Update Your Info UILabel
        self.updateYourInfo.text = "Update your email and password"
        self.updateYourInfo.textColor = FlatBlue().darkenByPercentage(0.2)
        self.updateYourInfo.font = UIFont.pandaFontMedium(withSize: 20)
        
        //Set Styling for Email/Password UITextFields
        self.password.backgroundColor = UIColor.flatGrayColor().lightenByPercentage(0.2)
        self.email.backgroundColor = UIColor.flatGrayColor().lightenByPercentage(0.2)
        self.password.layer.cornerRadius = 5
        self.email.layer.cornerRadius = 5
        
        //Format Placeholder Text in Email/Password UITextFields
        self.password.placeholder = "PASSWORD"
        self.email.placeholder = FIRAuth.auth()!.currentUser!.email?.uppercaseString
        self.email.textAlignment = .Center
        self.password.textAlignment = .Center
        
        //Stying for Save Changes & Cancel Buttons
        self.saveChangesButton.titleLabel?.numberOfLines = 2
        self.saveChangesButton.titleLabel?.textAlignment = .Center
        self.saveChangesButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.saveChangesButton.shadowHeight = 5
        self.saveChangesButton.buttonPressDepth = 0.65
        self.saveChangesButton.cornerRadius = 5
        self.saveChangesButton.titleLabel?.textColor = FlatWhite()
        self.saveChangesButton.buttonColor = FlatBlue()
        self.saveChangesButton.shadowColor = FlatBlue().darkenByPercentage(0.2)

        self.cancelButton.titleLabel?.numberOfLines = 2
        self.cancelButton.titleLabel?.textAlignment = .Center
        self.cancelButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.cancelButton.shadowHeight = 5
        self.cancelButton.buttonPressDepth = 0.65
        self.cancelButton.cornerRadius = 5
        self.cancelButton.titleLabel?.textColor = FlatWhite()
        self.cancelButton.buttonColor = FlatBlue()
        self.cancelButton.shadowColor = FlatBlue().darkenByPercentage(0.2)
        
    }
}
