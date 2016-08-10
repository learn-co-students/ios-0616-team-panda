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

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate, GIDSignInUIDelegate  {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginButton = SwiftyButton()
    var signupButton = SwiftyButton()
    var orLabel = UILabel()
    var googleLoginButton = GIDSignInButton()
    var facebookLoginButton = FBSDKLoginButton()
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showTabBarViewForUser()
    }
    
    @IBAction func loginButtonTapped(sender: UIButton!) {
        print("Submit Tapped!")
        if self.emailTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty {
            print("User didn't input any text in email / password fields when trying to log in...")
            self.validEmailPasswordAlert()
        } else {
            self.loginCurrentUser()
        }
    }
    
    @IBAction func signupButtonTapped(sender: UIButton!) {
        print("Signup Tapped!")
        if self.emailTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty {
            print("User email / password not valid or already in system...")
            let newUserAlertController = UIAlertController(title: "Uh oh...", message: "Please enter a valid email address & password.", preferredStyle: .Alert)
            let newUserCancelAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
            newUserAlertController.addAction(newUserCancelAction)
            self.presentViewController(newUserAlertController, animated: true, completion: nil)
        } else if self.passwordTextField.text?.characters.count < 6 {
            print("User password not valid...")
            let newUserAlertController = UIAlertController(title: "Uh oh...", message: "Please enter a valid password with at least 6 characters.", preferredStyle: .Alert)
            let newUserCancelAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
            newUserAlertController.addAction(newUserCancelAction)
            self.presentViewController(newUserAlertController, animated: true, completion: nil)
        } else if !self.newUserVerified() {
            print("User didn't input any text in email / password fields when trying to sign up...")
            let newUserAlertController = UIAlertController(title: "Uh oh...", message: "We already have that email in our records. Please try again or login.", preferredStyle: .Alert)
            let newUserCancelAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: nil)
            newUserAlertController.addAction(newUserCancelAction)
            self.presentViewController(newUserAlertController, animated: true, completion: nil)
        } else{
            self.createNewUser()
            let signUpQuestionVC = SignUpPageViewController()
            self.presentViewController(signUpQuestionVC, animated: true) {
                print("User signed in & moved to signUpQuestionVC")
            }
        }
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
        
        self.view.backgroundColor = UIColor.grayColor()
        self.emailTextField.backgroundColor = UIColor.whiteColor()
        self.passwordTextField.backgroundColor = UIColor.whiteColor()
        self.loginButton.buttonColor = UIColor.blueColor()
        self.loginButton.shadowHeight = 6
        self.loginButton.shadowColor = UIColor.whiteColor()
        self.loginButton.buttonPressDepth = 0.5
        self.loginButton.titleLabel?.font = UIFont.pandaFontMedium(withSize: 17)
        self.signupButton.buttonColor = UIColor.blueColor()
        self.signupButton.shadowHeight = 6
        self.signupButton.shadowColor = UIColor.whiteColor()
        self.signupButton.buttonPressDepth = 0.5
        self.signupButton.titleLabel?.font = UIFont.pandaFontMedium(withSize: 17)
        
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
        self.loginButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(30)
            make.centerX.equalTo(self.view).offset(50)
            make.width.equalTo(self.view.widthAnchor).offset(75)
            make.height.equalTo(self.view.heightAnchor).offset(25)
        }
        self.signupButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(30)
            make.centerX.equalTo(self.view).offset(-50)
            make.width.equalTo(self.view.widthAnchor).offset(75)
            make.height.equalTo(self.view.heightAnchor).offset(25)
        }
    }
    
    func createNewUser() {
        
        guard
            let userEmail = self.emailTextField.text,
            let userPassword = self.passwordTextField.text else { fatalError("There's no text in username / password fields!") }
        
        FIRAuth.auth()?.createUserWithEmail(userEmail, password: userPassword, completion: { (user, error) in
            if error != nil {
                print("There was a problem creating a new user: \(error?.localizedDescription)")
                
            } else {
                print("New user created!")
                guard let uid = user?.uid else {fatalError("Create new user unsuccessful!")}
                let values = ["email": userEmail,
                ]
                self.ref = FIRDatabase.database().referenceFromURL("https://career-options.firebaseio.com/")
                let usersReference = self.ref.child("users").child(uid)
                usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print("There was an issue with creating a new user in the Firebase database: \(error?.localizedDescription)")
                    }
                    print("User successfully saved into the Firebase database!")
                })
            }
        })
    }
    
    func newUserVerified() -> Bool {
        var userVerified = false
        guard
            let userEmail = self.emailTextField.text,
            let userPassword = self.passwordTextField.text else { fatalError("There's no text in username / password fields!") }
        FIRAuth.auth()?.createUserWithEmail(userEmail, password: userPassword, completion: { (user, error) in
            if error != nil {
                userVerified = false
            } else {
                userVerified = true
            }
        })
        return userVerified
    }
    
    func loginCurrentUser() {
        guard let userEmail = self.emailTextField.text,
            let userPassword = self.passwordTextField.text else { fatalError("There's no text in username / password fields!") }
        FIRAuth.auth()?.signInWithEmail(userEmail, password: userPassword, completion: { (user, error) in
            if error != nil {
                if let error = error {
                    print("There was a problem logging in a current user: \(error.localizedDescription)")
                    // Alert user there was a problem logging in
                    let noTextAlertController = UIAlertController(title: "Uh oh...", message: error.localizedDescription, preferredStyle: .Alert)
                    let noTextAction = UIAlertAction(title: "Try Again", style: .Cancel, handler: { (action) in
                        
                    })
                    noTextAlertController.addAction(noTextAction)
                    self.presentViewController(noTextAlertController, animated: true, completion: nil)
                }
            }
            print("User logged in successfully!")
            self.showTabBarViewForUser()
        })
    }
    
    func userAlreadyLoggedIn() -> Bool {
        if FIRAuth.auth()?.currentUser != nil {
            return true
        }
        return false
    }
    
    func showTabBarViewForUser() {
        if self.userAlreadyLoggedIn() {
            guard let tabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") else {fatalError("Couldn't go from User Sign In to Tab Bar View Controller.")}
            self.presentViewController(tabBarVC, animated: true, completion: {
                print("User logged in & moved to tab bar controller!")
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
                        print("Facebook user's email: \(fbUser.email), Facebook user's Display Name: \(fbUser.displayName), Facebook user's photoURL: \(fbUser.photoURL)")
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