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
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate  {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var submitButton = UIButton()
    var orLabel = UILabel()
    var googleLoginButton = GIDSignInButton()
    var facebookLoginButton = FBSDKLoginButton()
    
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
        self.passwordTextField.secureTextEntry = true
        
        self.usernameTextField.placeholder = "Username"
        self.passwordTextField.placeholder = "Password"
        self.orLabel.text = "OR"
        self.orLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.orLabel)
        
        self.submitButton.setTitle("Submit", forState: .Normal)
        self.submitButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.submitButton.addTarget(self, action: #selector(self.submitTapped), forControlEvents: .TouchUpInside)
        self.facebookLoginButtonSetup()
        self.googleLoginButtonSetup()
        
        self.view.addSubview(self.usernameTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(submitButton)
        
        self.textFieldConstraints()
        self.orLabel.snp_makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(45)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(60)
        }
        self.submitButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(30)
            make.centerX.equalTo(self.view)
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        
        self.view.backgroundColor = UIColor.grayColor()
        self.usernameTextField.backgroundColor = UIColor.whiteColor()
        self.passwordTextField.backgroundColor = UIColor.whiteColor()
        self.submitButton.backgroundColor = UIColor.lightGrayColor()
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
    
//    func handleLogin() {
//        g
//        
//        FIRAuth.auth()?.signInWithEmail(<#T##email: String##String#>, password: <#T##String#>, completion: <#T##FIRAuthResultCallback?##FIRAuthResultCallback?##(FIRUser?, NSError?) -> Void#>)
//    }
    
    func facebookLoginButtonSetup() {
        
        self.facebookLoginButton.delegate = self
        self.facebookLoginButton.readPermissions = ["public_profile", "email"]
        self.view.addSubview(self.facebookLoginButton)
        self.facebookLoginButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view)
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // loginButton didCompleteWithResult + logButtonDidLogOut methods necessary to conform to FBSDKLoginButtonDelegate protocol.
        print("FB User Logged In!")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("FB User Logged Out!")
    }
    
    func googleLoginButtonSetup() {
        
        GIDSignIn.sharedInstance().uiDelegate = self
        self.view.addSubview(self.googleLoginButton)
        self.googleLoginButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(150)
            make.centerX.equalTo(self.view)
        }
    }
}