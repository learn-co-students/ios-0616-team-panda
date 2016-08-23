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
        
        DataStore.store.tpUser?.updateUserProfile(withEmail : self.email.text!, completion: { (alert, message) in
            
            if message == "Error" {
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else { // successs
//                
//                alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) in
//                    
//                    self.dismissViewControllerAnimated(true) { }
//                    
//                }))
                
                self.presentViewController(alert, animated: true, completion: {
                    
                    self.styleUserProfileViews()
                    
                })
                
//                self.dismissViewControllerAnimated(true) { print("Dismissed User Profile View VC") }
//                self.dismissViewControllerAnimated(true) { print("Second call to save.") }
            }
            
        })
    }

    @IBAction func cancelButtonTapped(sender: UIButton!) {
        print("Cancel Button Tapped")
        self.dismissViewControllerAnimated(true) { 
            print("Dismissed User Profile View VC")
        }
    }
    

    func createViews() {
        self.saveChangesButton.setTitle("Save Changes", forState: .Normal)
        self.saveChangesButton.addTarget(self, action: #selector(saveChangesButtonTapped), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(cancelButton)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(saveChangesButton)
        self.view.addSubview(updateYourInfo)
        self.view.addSubview(resetPasswordButton)
        
        self.password.translatesAutoresizingMaskIntoConstraints = false
        self.email.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveChangesButton.translatesAutoresizingMaskIntoConstraints = false
        self.updateYourInfo.translatesAutoresizingMaskIntoConstraints = false
        self.resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        self.password.hidden = true
        
        self.email.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active=true
        self.email.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active=true
        self.email.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.email.bottomAnchor.constraintEqualToAnchor(self.password.topAnchor).active = true
        
        self.saveChangesButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.saveChangesButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: self.view.bounds.height/6).active = true
        self.saveChangesButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.saveChangesButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
        
        self.cancelButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.cancelButton.centerYAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -self.view.bounds.height/6).active = true
        self.cancelButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.cancelButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
        
        self.resetPasswordButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        self.resetPasswordButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.resetPasswordButton.topAnchor.constraintEqualToAnchor(self.email.bottomAnchor, constant: 25.0).active = true
        self.resetPasswordButton.bottomAnchor.constraintEqualToAnchor(self.saveChangesButton.topAnchor, constant: -25.0).active = true
        self.resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), forControlEvents: .TouchUpInside)
    }
    
    func resetPasswordTapped() {
        
        if let email = DataStore.store.tpUser?.email {
            
            FIRAuth.auth()?.sendPasswordResetWithEmail(email, completion: { (error) in
                if let error = error {
                    let errorAlert = Constants.displayAlertWithTryAgain("Something Went Wrong!", message: error.localizedDescription)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }
                else {
                    let alert = Constants.displayAlertWith("Email sent!", message: "Please check your email to reset your password.", actionLabel: "Okay", style: .Default, actionHandler: {
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                    })
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
        
    }
    
    func styleUserProfileViews() {
        
        self.view.backgroundColor = FlatWhite()
        
//        self.userAvatarImage.layer.cornerRadius = 50
//        self.userAvatarImage.backgroundColor = UIColor.flatOrangeColor()
        
        //Styling for Update Your Info UILabel
        self.updateYourInfo.text = "Update your email or reset your password"
        self.updateYourInfo.numberOfLines = 2
        self.updateYourInfo.textAlignment = .Center
        self.updateYourInfo.textColor = FlatBlue().darkenByPercentage(0.2)
        self.updateYourInfo.font = UIFont.pandaFontMedium(withSize: 20)
        
        //Set Styling for Email/Password UITextFields
        self.password.backgroundColor = UIColor.flatGrayColor().lightenByPercentage(0.2)
        self.email.backgroundColor = UIColor.flatGrayColor().lightenByPercentage(0.2)
        self.password.layer.cornerRadius = 5
        self.email.layer.cornerRadius = 5
        
        //Format Placeholder Text in Email/Password UITextFields
        self.password.placeholder = "Password"
        self.password.secureTextEntry = true
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
        
        self.resetPasswordButton.setTitle("Reset Password", forState: .Normal)
        self.resetPasswordButton.titleLabel?.textAlignment = .Center
        self.resetPasswordButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 16.0)
        self.resetPasswordButton.shadowHeight = 5
        self.resetPasswordButton.buttonPressDepth = 0.65
        self.resetPasswordButton.cornerRadius = 5
        self.resetPasswordButton.titleLabel?.textColor = FlatWhite()
        self.resetPasswordButton.buttonColor = FlatMint()
        self.resetPasswordButton.shadowColor = FlatMint().darkenByPercentage(0.2)
    }
}
