//
//  LoginViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAndAddViews()
    }

    @IBAction func submitTapped(sender: UIButton!) {
        print("Submit Tapped!")
    }
    
    func createAndAddViews() {
        
        self.usernameTextField = UITextField()
        self.passwordTextField = UITextField()
//        self.usernameTextField.becomeFirstResponder()
//        self.passwordTextField.resignFirstResponder()
        self.usernameTextField.placeholder = "Username"
        self.passwordTextField.placeholder = "Password"
        let submitButton = UIButton()
        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.setTitleColor(.blueColor(), forState: .Normal)
        submitButton.addTarget(self, action: #selector(self.submitTapped), forControlEvents: .TouchUpInside)
        self.facebookLoginButton()
        
        self.view.addSubview(self.usernameTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(submitButton)
        
        self.textFieldConstraints()
        submitButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        
        self.view.backgroundColor = UIColor.cyanColor()
        self.usernameTextField.backgroundColor = UIColor.whiteColor()
        self.passwordTextField.backgroundColor = UIColor.whiteColor()
        submitButton.backgroundColor = UIColor.brownColor()
    }
    
    func textFieldConstraints() {
        
        self.usernameTextField.textAlignment = NSTextAlignment.Center
        self.passwordTextField.textAlignment = NSTextAlignment.Center
        
        self.usernameTextField.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(-50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        
        self.passwordTextField.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(-15)
            make.centerX.equalTo(self.view)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
    }
    
    func facebookLoginButton() {
        let facebookLoginButton = UIButton()
        facebookLoginButton.setTitle("Login with Facebook!", forState: .Normal)
        facebookLoginButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        facebookLoginButton.addTarget(self, action: #selector(self.fbLoginButtonTapped), forControlEvents: .TouchUpInside)
        facebookLoginButton.backgroundColor = UIColor.redColor()
        self.view.addSubview(facebookLoginButton)
        facebookLoginButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
    }
    
    func fbLoginButtonTapped() {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["public_profile"], fromViewController: self) { (result, error) in
            if error != nil {
                print ("There was a processing error \(error.localizedDescription)")
            } else if result.isCancelled {
                print("Cancelled")
            } else {
                print("Log in successful!")
            }
        }
    }
}