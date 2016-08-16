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
import SwiftyButton
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate, GIDSignInUIDelegate  {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginButton = SwiftyButton()
    var signupButton = SwiftyButton()
    var orLabel = UILabel()
    var googleLoginButton = GIDSignInButton()
    var facebookLoginButton = FBSDKLoginButton()
    var ref: FIRDatabaseReference!
    let store = DataStore.store
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showTabBarViewForUser()
    }
    
    @IBAction func loginButtonTapped(sender: UIButton!) {
        if self.emailTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty {
            self.validEmailPasswordAlert()
        } else {
            self.loginCurrentUser()
        }
    }
    
    @IBAction func signupButtonTapped(sender: UIButton!) {
        self.createNewUser()
    }
    
    func createAndAddViews() {
        
        self.emailTextField = UITextField()
        self.emailTextField.delegate = self
        self.passwordTextField = UITextField()
        self.passwordTextField.delegate = self
        self.passwordTextField.secureTextEntry = true
        
        self.emailTextField.placeholder = "E-Mail"
        self.passwordTextField.placeholder = "Password"
        self.orLabel.text = "OR"
        self.orLabel.textAlignment = NSTextAlignment.Center
        self.orLabel.hidden = true
        
        self.loginButton.setTitle("Login", forState: .Normal)
        self.loginButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), forControlEvents: .TouchUpInside)
        self.signupButton.setTitle("Signup", forState: .Normal)
        self.signupButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.signupButton.addTarget(self, action: #selector(self.signupButtonTapped), forControlEvents: .TouchUpInside)
        self.facebookLoginButtonSetup()
        self.googleLoginButtonSetup()
        
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signupButton)
        self.view.addSubview(self.orLabel)
        
        self.viewsConstraints()
        
        self.view.backgroundColor = FlatBlueDark()
        self.emailTextField.backgroundColor = FlatWhite()
        self.passwordTextField.backgroundColor = FlatWhite()
        self.loginButton.buttonColor = FlatMintDark().darkenByPercentage(0.1)
        self.loginButton.highlightedColor = FlatMintDark().darkenByPercentage(0.2)
        self.loginButton.shadowHeight = 5
        self.loginButton.shadowColor = FlatMintDark().darkenByPercentage(0.2)
        self.loginButton.buttonPressDepth = 0.65
        self.loginButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20)
        self.signupButton.buttonColor = FlatMintDark().darkenByPercentage(0.1)
        self.signupButton.highlightedColor = FlatMintDark().darkenByPercentage(0.2)
        self.signupButton.shadowHeight = 5
        self.signupButton.shadowColor = FlatMintDark().darkenByPercentage(0.2)
        self.signupButton.buttonPressDepth = 0.65
        self.signupButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Dismisses keyboard when user taps return in either Username or Password UITextFields
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    func viewsConstraints() {
        
        self.emailTextField.textAlignment = NSTextAlignment.Center
        self.passwordTextField.textAlignment = NSTextAlignment.Center
        
        self.emailTextField.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(-50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view.widthAnchor).offset(300)
            make.height.equalTo(self.view.heightAnchor).offset(20)
        }
        
        self.passwordTextField.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(-15)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view.widthAnchor).offset(300)
            make.height.equalTo(self.view.heightAnchor).offset(20)
        }
        
        self.orLabel.snp_makeConstraints { (make) in
            make.width.equalTo(self.view.widthAnchor).offset(40)
            make.height.equalTo(self.view.heightAnchor).offset(45)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(60)
        }
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.loginButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant:  self.view.bounds.height/6).active = true
        self.loginButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.loginButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.125).active = true
        
        self.signupButton.translatesAutoresizingMaskIntoConstraints = false
        self.signupButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.signupButton.centerYAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -self.view.bounds.height/6).active = true
        self.signupButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier:  0.75).active = true
        self.signupButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier:  0.125).active = true
        
    }
    
    func createNewUser() {
        
        let userEmail = self.emailTextField!.text!
        let userPassword = self.passwordTextField!.text!
        
        FIRAuth.auth()?.createUserWithEmail(userEmail, password: userPassword, completion: { (user, error) in
            if error != nil {
                // Don't create user
                let alert = Constants.displayAlertWithTryAgain("Uh oh...", message: (error?.localizedDescription)!)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.presentViewController(SignUpPageViewController(), animated: true, completion: nil)
                print("User successfully saved into the Firebase database! \(user?.uid) + \(user?.email)")
                
                let pandaUser: TPUser = TPUser(withEmail: (user?.email)!, uid: (user?.uid)!)
                pandaUser.updateDatabase()
                self.store.tpUser = pandaUser
            }
        })
    }
    
    func loginCurrentUser() {
        guard let userEmail = self.emailTextField.text,
            let userPassword = self.passwordTextField.text else {
                print("There's no text in username / password fields!")
                return
        }
        
        FIRAuth.auth()?.signInWithEmail(userEmail, password: userPassword, completion: { (user, error) in
            if let error = error {
                // Alert user there was a problem logging in
                let alert = Constants.displayAlertWithTryAgain("Uh oh...", message: error.localizedDescription)
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else if let user = user {
                
                TPUser.getUserFromFirebase(user.uid, completion: { (pandaUser) in
                    self.store.tpUser = pandaUser
                    self.showTabBarViewForUser()
                })
                
            } else {
                print("Couldn't get user.")
                return
            }
        })
    }
    
    func userAlreadyLoggedIn() -> Bool {
        
        if let currentPandauser = FIRAuth.auth()?.currentUser {
            TPUser.getUserFromFirebase(currentPandauser.uid, completion: { (pandaUser) in
                self.store.tpUser = pandaUser
            })
            return true
        }
        return false
    }
    
    func showTabBarViewForUser() {
        if self.userAlreadyLoggedIn() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = storyboard.instantiateViewControllerWithIdentifier("tabBarController")
            self.presentViewController(tabBarVC, animated: true, completion: {
            })
        } else {
            self.createAndAddViews()
        }
    }
    
    func validEmailPasswordAlert() {
        let noTextAlertController = UIAlertController(title: "Uh oh...", message: "Please enter a valid email address & password", preferredStyle: .Alert)
        let noTextAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: { (action) in
            
        })
        noTextAlertController.addAction(noTextAction)
        self.presentViewController(noTextAlertController, animated: true, completion: nil)
    }
    
    func facebookLoginButtonSetup() {
        
        self.facebookLoginButton.delegate = self
        self.facebookLoginButton.readPermissions = ["public_profile", "email"]
        self.view.addSubview(self.facebookLoginButton)
        self.facebookLoginButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view)
        }
        self.facebookLoginButton.hidden = true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // Confirms Facebook login, adds FB user to Firebase users.
        // loginButton didCompleteWithResult + logButtonDidLogOut methods necessary to conform to FBSDKLoginButtonDelegate protocol.
        if let error = error {
            print("Something wrong with Facebook login button in AppDelegate \(error.localizedDescription)")
            return
        }
        
        if result.isCancelled {
            // Ensures if user taps done without logging in with FB it takes the user back to the login screen.
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let fbCredential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            FIRAuth.auth()?.signInWithCredential(fbCredential, completion: { (fbUser, error) in
                if error != nil {
                    print("There was an error Authorizing Facebook user with Firebase: \(error?.localizedDescription)")
                } else {
                    if let fbUser = fbUser {
                        print("Facebook user's email: \(fbUser.email), Facebook user's Display Name: \(fbUser.displayName), Facebook user's photoURL: \(fbUser.photoURL), Facebook user's UID: \(fbUser.uid)")
                        if let fbUserEmail = fbUser.email {
                            let values = ["email": fbUserEmail,
                            ]
                            self.ref = FIRDatabase.database().referenceFromURL("https://career-options.firebaseio.com/")
                            let usersReference = self.ref.child("users")
                            usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                                if error != nil {
                                    print("There was an issue with creating a new Facebook user in the Firebase database: \(error?.localizedDescription)")
                                }
                                print("Facebook user successfully saved into the Firebase database!")
                            })
                        }
                    }
                    self.showTabBarViewForUser()
                }
            })
        }
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
        self.googleLoginButton.hidden = true
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        // This method is necessary to conform to GIDSignInUIDelegate protocol.
        if error != nil {
            print("There was a google signin error!\(error.localizedDescription)")
            return
        }
        // print("User Email: \(user.profile.email), Profile Picture: \(user.profile.imageURLWithDimension(400))")
    }
}