//
//  SettingsViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import FirebaseAuth
import ChameleonFramework
import SwiftFontName
import SwiftyButton

class SettingsViewController: UIViewController {

    var updateProfileButton     : PressableButton!
    var refreshQuestionsButton  : PressableButton!
    var logOutButton            : PressableButton!
    
    let store = DataStore.store
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.flatSkyBlue()
        setupButtons()
    }
    
    func updateProfileTapped(_ sender : Any) {
        print("Update Profile Info Tapped")
        
        if store.tpUser?.uid == Secrets.genericUserUID {
            let alert = Constants.displayAlertWith("Oops!", message: "Only logged in users can update their profile info. Go to Settings > Log Out and sign up to unlock full access to CareerSpark. It's free!", actionLabel: "Got it!", style: .default, actionHandler: { })
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.present(UserProfileViewController(), animated: true, completion: nil)
        }
    }
    
    func refreshQuestionaireTapped(_ sender : AnyObject) {
        print("Refresh Questionaire")
        self.present(SignUpPageViewController(), animated: true, completion: nil)
    }
    
    func logoutTapped(_ sender : AnyObject) {
        print("Log Out")
        
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?\nYour information will be saved if you log back in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
            
            do{
                try FIRAuth.auth()?.signOut()
            }  catch {fatalError("Unable to log user out")}
            self.present(LoginViewController(), animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            print("User didn't want to log out. Hide alert.")
        }))
        
        self.present(alert, animated: true, completion: {
            print("Finished presenting alert.")
        })
    }
    
    func setupButtons() {
        
        self.updateProfileButton = PressableButton()
        self.updateProfileButton.setTitleColor(FlatSkyBlueDark(), for: .normal)
        self.updateProfileButton.setTitle("Update Profile Info", for: .normal)
        self.updateProfileButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.updateProfileButton.colors = .init(button: FlatWhite(), shadow: FlatWhiteDark())
        self.updateProfileButton.shadowHeight = 5
        self.updateProfileButton.depth = 0.65
        self.updateProfileButton.cornerRadius = 5
        
        self.updateProfileButton.addTarget(self, action: #selector(updateProfileTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(self.updateProfileButton)
        self.updateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.updateProfileButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65).isActive = true
        self.updateProfileButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6.0).isActive = true
        self.updateProfileButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.updateProfileButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -self.view.bounds.height*1/4.0).isActive = true
        
        self.refreshQuestionsButton = PressableButton()
        self.refreshQuestionsButton.setTitleColor(FlatSkyBlueDark(), for: .normal)
        self.refreshQuestionsButton.setTitle("Refresh Questionaire", for: .normal)
        self.refreshQuestionsButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.refreshQuestionsButton.colors = .init(button: FlatWhite(), shadow: FlatWhiteDark())
        self.refreshQuestionsButton.shadowHeight = 5
        self.refreshQuestionsButton.depth = 0.65
        self.refreshQuestionsButton.cornerRadius = 5
        
        self.refreshQuestionsButton.addTarget(self, action: #selector(refreshQuestionaireTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(self.refreshQuestionsButton)
        self.refreshQuestionsButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshQuestionsButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65).isActive = true
        self.refreshQuestionsButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6.0).isActive = true
        self.refreshQuestionsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.refreshQuestionsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        self.logOutButton = PressableButton()
        self.logOutButton.setTitleColor(FlatSkyBlueDark(), for: .normal)
        self.logOutButton.setTitle("Log Out", for: .normal)
        self.logOutButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.logOutButton.colors = .init(button: FlatWhite(), shadow: FlatWhiteDark())
        self.logOutButton.shadowHeight = 5
        self.logOutButton.depth = 0.65
        self.logOutButton.cornerRadius = 5
        
        self.logOutButton.addTarget(self, action: #selector(logoutTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(self.logOutButton)
        self.logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.logOutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65).isActive = true
        self.logOutButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6.0).isActive = true
        self.logOutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.logOutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.height*1/4.0).isActive = true
    }
    
}
