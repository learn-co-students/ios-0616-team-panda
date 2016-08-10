//
//  UserProfileViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    
    var email = UITextField()
    var password = UITextField()
    
    var saveChangesButton = UIButton()
    var cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        
    }
    
    @IBAction func saveChangesButtonTapped(sender: UIButton!) {
        
        print("Save Changes Button Tapped")
        
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton!) {
        
        print("Cancel Button Tapped")
        self.presentViewController(SettingsViewController(), animated: true, completion: nil)
        
    }

    func createViews() {
        
        self.saveChangesButton.setTitle("Save Changes", forState: .Normal)
        self.saveChangesButton.addTarget(self, action: #selector(saveChangesButtonTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(saveChangesButton)
        
        self.cancelButton.setTitle("Cancel", forState: .Normal)
        self.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(cancelButton)
        self.view.addSubview(email)
        self.view.addSubview(password)
        
        self.password.translatesAutoresizingMaskIntoConstraints=false
        self.email.translatesAutoresizingMaskIntoConstraints=false
        self.cancelButton.translatesAutoresizingMaskIntoConstraints=false
        self.saveChangesButton.translatesAutoresizingMaskIntoConstraints=false
        
        self.password.backgroundColor = UIColor.blueColor()
        self.email.backgroundColor = UIColor.greenColor()
        
        self.email.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active=true
        self.email.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active=true
        self.email.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active=true
        self.email.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active=true
        
        self.password.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active=true
        self.password.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active=true
        self.password.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active=true
        self.password.topAnchor.constraintEqualToAnchor(self.email.bottomAnchor).active=true
        
        
        self.saveChangesButton.rightAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active=true
      //  self.saveChangesButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active=true
        self.saveChangesButton.topAnchor.constraintEqualToAnchor(self.password.bottomAnchor).active=true
        
        self.cancelButton.leftAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active=true
        self.cancelButton.topAnchor.constraintEqualToAnchor(self.password.bottomAnchor).active=true

        
        
    }
}
