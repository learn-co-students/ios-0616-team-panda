//
//  LoginViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SwiftFontName
import FirebaseAuth
import FirebaseDatabase
import SwiftyButton
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginButton = PressableButton()
    var signupButton = PressableButton()
    var orLabel = UILabel()
    var ref: DatabaseReference!
    let store = DataStore.store
    let webViewBG = UIWebView()
    let careerSparkLabel = UILabel()
    var careerSparkHeadlineLabel = UILabel()
    var filterView = UIView()
    
    lazy var continueWithoutLoginButton : UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTabBarViewForUser()
        
    }
    
    func dismissKeyboard() {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func showTabBarViewForUser() {
        
        if let currentPanda = Auth.auth().currentUser {
            
            if currentPanda.uid == Secrets.genericUserUID {
                self.displayLoginView()
            }
            else {
                TPUser.getUserFromFirebase(currentPanda.uid, completion: { (pandaUser) in
                    if let pandaUser = pandaUser {
                        self.store.tpUser = pandaUser
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "tabBarController")
                        self.present(tabBarVC, animated: true, completion: {
                        })
                    } else {
                        self.displayLoginView()
                    }
                })
            }
        } else { // no user
            self.displayLoginView()
        }
    }
    
    func displayLoginView() {
        emailTextField = UITextField()
        emailTextField.delegate = self
        emailTextField.layer.cornerRadius = 5
        emailTextField.alpha = 0.8
        passwordTextField = UITextField()
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.alpha = 0.8
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        emailTextField.placeholder = "E-Mail"
        passwordTextField.placeholder = "Password"
        orLabel.text = "OR"
        orLabel.textAlignment = NSTextAlignment.center
        orLabel.isHidden = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.setTitle("Signup", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        
        continueWithoutLoginButton.setTitle("Continue without logging in.", for: UIControlState())
        continueWithoutLoginButton.titleLabel?.textColor = UIColor.white
        continueWithoutLoginButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 13.0)
        continueWithoutLoginButton.reversesTitleShadowWhenHighlighted = true
        continueWithoutLoginButton.setTitleColor(FlatMint(), for: .highlighted)
        continueWithoutLoginButton.addTarget(self, action: #selector(signInAsGenericUserTapped), for: .touchUpInside)
        
        view.addSubview(filterView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(orLabel)
        view.addSubview(continueWithoutLoginButton)
        
        viewsConstraints()
        
        let filePath = Bundle.main.path(forResource: "sparkTop2", ofType: "gif")
        let gif = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        
        
        view.addSubview(webViewBG)
        webViewBG.translatesAutoresizingMaskIntoConstraints = false
        webViewBG.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        webViewBG.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        webViewBG.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        webViewBG.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        webViewBG.load(gif!, mimeType: "image/gif", textEncodingName: "", baseURL: URL(string: "google.com")!)
        //        webViewBG.load(gif!, mimeType: "image/gif", textEncodingName: String(), baseURL: URL())
        webViewBG.isUserInteractionEnabled = false
        
        view.addSubview(careerSparkLabel)
        view.addSubview(careerSparkHeadlineLabel)
        
        
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        filterView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        filterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filterView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        filterView.backgroundColor = UIColor.flatBlack
        view.sendSubview(toBack: filterView)
        filterView.alpha = 0.2
        
        careerSparkLabel.translatesAutoresizingMaskIntoConstraints = false
        careerSparkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        careerSparkLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        careerSparkLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        careerSparkLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        careerSparkHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        careerSparkHeadlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        careerSparkHeadlineLabel.topAnchor.constraint(equalTo: careerSparkLabel.bottomAnchor).isActive = true
        careerSparkHeadlineLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        careerSparkHeadlineLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        careerSparkLabel.text = "CareerSpark"
        careerSparkLabel.textColor = UIColor.white
        careerSparkLabel.font = UIFont(name: FontName.TrebuchetMSBold, size: 44)
        careerSparkLabel.textAlignment = NSTextAlignment.center
        careerSparkLabel.adjustsFontSizeToFitWidth = true
        
        careerSparkHeadlineLabel.text = "Discover your new career."
        careerSparkHeadlineLabel.textColor = UIColor.white
        careerSparkHeadlineLabel.font = UIFont.pandaFontMedium(withSize: 20)
        careerSparkHeadlineLabel.textAlignment = NSTextAlignment.center
        view.sendSubview(toBack: webViewBG)
        
        view.backgroundColor = FlatBlueDark()
        emailTextField.backgroundColor = FlatWhite()
        passwordTextField.backgroundColor = FlatWhite()
        loginButton.colors = .init(button: FlatMintDark().darken(byPercentage: 0.1)!, shadow: FlatMintDark().darken(byPercentage: 0.2)!)
        loginButton.shadowHeight = 5
        loginButton.depth = 0.65
        loginButton.titleLabel!.font = UIFont.pandaFontLight(withSize: 20)
        signupButton.colors = .init(button: FlatMintDark().darken(byPercentage: 0.1)!, shadow: FlatMintDark().darken(byPercentage: 0.2)!)
        signupButton.shadowHeight = 5
        signupButton.depth = 0.65
        signupButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton!) {
        
        if !self.emptyTextFields() {
            self.loginCurrentUser()
        } else {
            self.blankEmailPasswordAlert()
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton!) {
        self.createNewUser()
    }
    
    func viewsConstraints() {
        emailTextField.textAlignment = .center
        passwordTextField.textAlignment = .center
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        emailTextField.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.75).isActive = true
        emailTextField.safeHeightAnchor.constraint(equalTo: view.safeHeightAnchor, multiplier: 0.0935).isActive = true
        emailTextField.safeCenterYAnchor.constraint(equalTo: view.safeCenterYAnchor, constant: -view.bounds.height * 0.1).isActive = true

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        passwordTextField.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.75).isActive = true
        passwordTextField.safeHeightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0935).isActive = true
        
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, constant: 40).isActive = true
        orLabel.safeHeightAnchor.constraint(equalTo: view.safeHeightAnchor, constant: 45).isActive = true
        orLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        orLabel.safeCenterYAnchor.constraint(equalTo: view.safeCenterYAnchor, constant: 60).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        loginButton.safeCenterYAnchor.constraint(equalTo: view.safeCenterYAnchor, constant:  view.bounds.height/6).isActive = true
        loginButton.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.75).isActive = true
        loginButton.safeHeightAnchor.constraint(equalTo: view.safeHeightAnchor, multiplier: 0.125).isActive = true
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        signupButton.safeCenterYAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -view.bounds.height/6).isActive = true
        signupButton.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier:  0.75).isActive = true
        signupButton.safeHeightAnchor.constraint(equalTo: view.safeHeightAnchor, multiplier:  0.125).isActive = true
        
        continueWithoutLoginButton.translatesAutoresizingMaskIntoConstraints = false
        continueWithoutLoginButton.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        continueWithoutLoginButton.safeWidthAnchor.constraint(equalTo: loginButton.safeWidthAnchor).isActive = true
        continueWithoutLoginButton.safeTopAnchor.constraint(equalTo: passwordTextField.safeBottomAnchor).isActive = true
        continueWithoutLoginButton.safeBottomAnchor.constraint(equalTo: loginButton.safeTopAnchor).isActive = true
    }
    
    func signInAsGenericUserTapped() {
        
        let alert = Constants.displayAlertWithContinueAndCancel("Heads Up!", message: "Without logging in, you won't be able to save your answers to the survey or favorite any jobs. Would you like to continue?", continueHandler: { 
            // continueHandler
            
            Auth.auth().signIn(withEmail: Secrets.genericUserEmail, password: Secrets.genericUserPassword, completion: { (user, error) in
                
                if let error = error {
                    // Alert user there was a problem logging in
                    let alert = Constants.displayAlertWithTryAgain("Uh oh...", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    
                } else if let user = user {
                    
                    TPUser.getUserFromFirebase(user.uid, completion: { (pandaUser) in
                        self.store.tpUser = pandaUser
                        self.present(SignUpPageViewController(), animated: true, completion: nil)                        
                    })
                }
            })
            
            
        }) {
            return
        }
        
        self.present(alert, animated: true, completion: nil)
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
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginCurrentUser() {
        
        guard
            let userEmail = self.emailTextField.text,
            let userPassword = self.passwordTextField.text else {
                return
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword, completion: { (user, error) in
            
            if let error = error {
                // Alert user there was a problem logging in
                let alert = Constants.displayAlertWithTryAgain("Uh oh...", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                
            } else if let user = user {
                
                TPUser.getUserFromFirebase(user.uid, completion: { (pandaUser) in
                    self.store.tpUser = pandaUser
                    self.showTabBarViewForUser()
                    
                })
            }
        })
    }
    
    func createNewUser() {
        
        let userEmail = self.emailTextField!.text!
        let userPassword = self.passwordTextField!.text!
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: { (user, error) in
            if let error = error {
                // Don't create user
                let alert = Constants.displayAlertWithTryAgain("Uh oh...", message: (error.localizedDescription))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.present(SignUpPageViewController(), animated: true, completion: nil)
                let pandaUser: TPUser = TPUser(withEmail: (user?.email)!, uid: (user?.uid)!)
                pandaUser.updateDatabase()
                self.store.tpUser = pandaUser
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when user taps return in either Username or Password UITextFields
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
}
