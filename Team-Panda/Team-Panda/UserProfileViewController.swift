//
//  UserProfileViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftyButton
import ChameleonFramework
import SwiftFontName

class UserProfileViewController: UIViewController {
    
    var email = UITextField()
    var password = UITextField()
    var updateYourInfo = UILabel()
    var saveChangesButton = PressableButton()
    var cancelButton = PressableButton()
    var resetPasswordButton = PressableButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleUserProfileViews()
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: UIButton!) {
        
        DataStore.store.tpUser?.updateUserProfile(withEmail : self.email.text!, completion: { (alert, message) in
            
            if message == "Error" {
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                self.present(alert, animated: true, completion: {
                    
                    self.styleUserProfileViews()
                    
                })
            }
        })
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton!) {
        print("Cancel Button Tapped")
        self.dismiss(animated: true) {
            print("Dismissed User Profile View VC")
        }
    }
    
    
    func createViews() {
        self.saveChangesButton.setTitle("Save Changes", for: .normal)
        self.saveChangesButton.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)
        
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
        
        self.updateYourInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.updateYourInfo.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.updateYourInfo.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.updateYourInfo.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        self.password.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive=true
        self.password.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive=true
        self.password.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        self.password.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive=true
        self.password.isHidden = true
        
        self.email.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive=true
        self.email.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive=true
        self.email.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.email.bottomAnchor.constraint(equalTo: self.password.topAnchor).isActive = true
        
        self.saveChangesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.saveChangesButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.height/6).isActive = true
        self.saveChangesButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.saveChangesButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
        
        self.cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.cancelButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.bounds.height/6).isActive = true
        self.cancelButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.cancelButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
        
        self.resetPasswordButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        self.resetPasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.resetPasswordButton.topAnchor.constraint(equalTo: self.email.bottomAnchor, constant: 25.0).isActive = true
        self.resetPasswordButton.bottomAnchor.constraint(equalTo: self.saveChangesButton.topAnchor, constant: -25.0).isActive = true
        self.resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
    }
    
    func resetPasswordTapped() {
        
        if let email = DataStore.store.tpUser?.email {
            
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if let error = error {
                    let errorAlert = Constants.displayAlertWithTryAgain("Something Went Wrong!", message: error.localizedDescription)
                    self.present(errorAlert, animated: true, completion: nil)
                }
                else {
                    let alert = Constants.displayAlertWith("Email sent!", message: "Please check your email to reset your password.", actionLabel: "Okay", style: .default, actionHandler: {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    })
                    
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    func styleUserProfileViews() {
        
        self.view.backgroundColor = FlatWhite()
        
        //Styling for Update Your Info UILabel
        self.updateYourInfo.text = "Update your email or reset your password"
        self.updateYourInfo.numberOfLines = 2
        self.updateYourInfo.textAlignment = .center
        self.updateYourInfo.textColor = FlatBlue().darken(byPercentage: 0.2)
        self.updateYourInfo.font = UIFont.pandaFontMedium(withSize: 20)
        
        //Set Styling for Email/Password UITextFields
        self.password.backgroundColor = UIColor.flatGray.lighten(byPercentage: 0.2)
        self.email.backgroundColor = UIColor.flatGray.lighten(byPercentage: 0.2)
        self.password.layer.cornerRadius = 5
        self.email.layer.cornerRadius = 5
        
        //Format Placeholder Text in Email/Password UITextFields
        self.password.placeholder = "Password"
        self.password.isSecureTextEntry = true
        self.email.placeholder = Auth.auth().currentUser!.email?.uppercased()
        self.email.textAlignment = .center
        self.password.textAlignment = .center
        
        //Stying for Save Changes & Cancel Buttons
        self.saveChangesButton.titleLabel?.numberOfLines = 2
        self.saveChangesButton.titleLabel?.textAlignment = .center
        self.saveChangesButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.saveChangesButton.shadowHeight = 5
        self.saveChangesButton.depth = 0.65
        self.saveChangesButton.cornerRadius = 5
        self.saveChangesButton.titleLabel?.textColor = FlatWhite()
        self.saveChangesButton.colors = .init(button: FlatBlue(), shadow: FlatBlue().darken(byPercentage: 0.2)!)
        
        self.cancelButton.titleLabel?.numberOfLines = 2
        self.cancelButton.titleLabel?.textAlignment = .center
        self.cancelButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.cancelButton.shadowHeight = 5
        self.cancelButton.depth = 0.65
        self.cancelButton.cornerRadius = 5
        self.cancelButton.titleLabel?.textColor = FlatWhite()
        self.cancelButton.colors = .init(button: FlatBlue(), shadow: FlatBlue().darken(byPercentage: 0.2)!)
        
        self.resetPasswordButton.setTitle("Reset Password", for: .normal)
        self.resetPasswordButton.titleLabel?.textAlignment = .center
        self.resetPasswordButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 16.0)
        self.resetPasswordButton.shadowHeight = 5
        self.resetPasswordButton.depth = 0.65
        self.resetPasswordButton.cornerRadius = 5
        self.resetPasswordButton.titleLabel?.textColor = FlatWhite()
        self.resetPasswordButton.colors = .init(button: FlatMint(), shadow: FlatMint().darken(byPercentage: 0.2)!)
    }
}
