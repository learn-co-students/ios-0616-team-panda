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
import SwiftFontName
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
    let webViewBG = UIWebView()
    let careerSparkLabel = UILabel()
    var careerSparkHeadlineLabel = UILabel()
    var filterView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTabBarViewForUser()
        
    }
    
    func dismissKeyboard() {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func showTabBarViewForUser() {

        if let currentPanda = FIRAuth.auth()?.currentUser {
            TPUser.getUserFromFirebase(currentPanda.uid, completion: { (pandaUser) in
                if let pandaUser = pandaUser {
                    self.store.tpUser = pandaUser
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewControllerWithIdentifier("tabBarController")
                    self.presentViewController(tabBarVC, animated: true, completion: {
                    })
                } else {
                    self.displayLoginView()
                }
            })
        } else { // no user
            self.displayLoginView()
        }
    }
    
    func displayLoginView() {
        
        self.emailTextField = UITextField()
        self.emailTextField.delegate = self
        self.emailTextField.layer.cornerRadius = 5
        self.emailTextField.alpha = 0.8
        self.passwordTextField = UITextField()
        self.passwordTextField.delegate = self
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.layer.cornerRadius = 5
        self.passwordTextField.alpha = 0.8
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
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
        
        self.view.addSubview(filterView)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signupButton)
        self.view.addSubview(self.orLabel)
        
        self.viewsConstraints()
        
        let filePath = NSBundle.mainBundle().pathForResource("sparkTop2", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        self.view.addSubview(webViewBG)
        self.webViewBG.translatesAutoresizingMaskIntoConstraints = false
        self.webViewBG.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.webViewBG.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.webViewBG.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.webViewBG.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.userInteractionEnabled = false;
        
        self.view.addSubview(careerSparkLabel)
        self.view.addSubview(careerSparkHeadlineLabel)
        
        
        self.filterView.translatesAutoresizingMaskIntoConstraints = false
        self.filterView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.filterView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.filterView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.filterView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.filterView.backgroundColor = UIColor.flatBlackColor()
        self.view.sendSubviewToBack(filterView)
        self.filterView.alpha = 0.2
        
        self.careerSparkLabel.translatesAutoresizingMaskIntoConstraints = false
        self.careerSparkLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.careerSparkLabel.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.careerSparkLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.careerSparkLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.25).active = true
        
        self.careerSparkHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        self.careerSparkHeadlineLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.careerSparkHeadlineLabel.topAnchor.constraintEqualToAnchor(self.careerSparkLabel.bottomAnchor).active = true
        self.careerSparkHeadlineLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.careerSparkHeadlineLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.08).active = true
        
        careerSparkLabel.text = "CareerSpark"
        careerSparkLabel.textColor = UIColor.whiteColor()
        careerSparkLabel.font = UIFont(name: FontName.TrebuchetMSBold, size: 44)
        careerSparkLabel.textAlignment = NSTextAlignment.Center

        careerSparkHeadlineLabel.text = "Discover your new career."
        careerSparkHeadlineLabel.textColor = UIColor.whiteColor()
        careerSparkHeadlineLabel.font = UIFont.pandaFontMedium(withSize: 20)
        careerSparkHeadlineLabel.textAlignment = NSTextAlignment.Center
        self.view.sendSubviewToBack(webViewBG)
        
        self.view.backgroundColor = FlatBlueDark()
        self.emailTextField.backgroundColor = FlatWhite()
        self.passwordTextField.backgroundColor = FlatWhite()
        self.loginButton.buttonColor = FlatMintDark().darkenByPercentage(0.1)
        self.loginButton.highlightedColor = FlatMintDark().darkenByPercentage(0.2)
        self.loginButton.shadowHeight = 5
        self.loginButton.shadowColor = FlatMintDark().darkenByPercentage(0.2)
        self.loginButton.buttonPressDepth = 0.65
        self.loginButton.titleLabel!.font = UIFont.pandaFontLight(withSize: 20)
        self.signupButton.buttonColor = FlatMintDark().darkenByPercentage(0.1)
        self.signupButton.highlightedColor = FlatMintDark().darkenByPercentage(0.2)
        self.signupButton.shadowHeight = 5
        self.signupButton.shadowColor = FlatMintDark().darkenByPercentage(0.2)
        self.signupButton.buttonPressDepth = 0.65
        self.signupButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20)
        
    }
    
    @IBAction func loginButtonTapped(sender: UIButton!) {
        if !self.emptyTextFields() {
            self.loginCurrentUser()
        } else {
            self.blankEmailPasswordAlert()
        }
    }
    
    @IBAction func signupButtonTapped(sender: UIButton!) {
        self.createNewUser()
    }
    
    func viewsConstraints() {
        
        self.emailTextField.textAlignment = NSTextAlignment.Center
        self.passwordTextField.textAlignment = NSTextAlignment.Center
        
        self.emailTextField.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.75)
            make.height.equalTo(self.view).multipliedBy(0.0935)
            make.centerY.equalTo(self.view).offset(-self.view.bounds.height*0.09)
        }
        
        self.passwordTextField.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.75)
            make.height.equalTo(self.view).multipliedBy(0.0935)
            make.centerY.equalTo(self.view)
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
    
    func emptyTextFields() -> Bool {
        
        if self.emailTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func blankEmailPasswordAlert() {
        
        let alert = Constants.displayAlertWithTryAgain("Uh oh...", message: "Please enter a valid email address & password")
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loginCurrentUser() {
        
        guard
            let userEmail = self.emailTextField.text,
            let userPassword = self.passwordTextField.text else {
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
                return
            }
        })
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
                let pandaUser: TPUser = TPUser(withEmail: (user?.email)!, uid: (user?.uid)!)
                pandaUser.updateDatabase()
                self.store.tpUser = pandaUser
            }
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Dismisses keyboard when user taps return in either Username or Password UITextFields
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
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