//
//  LoginViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SnapKit
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
    var ref: FIRDatabaseReference!
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
        
        if let currentPanda = FIRAuth.auth()?.currentUser {
            
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
        
        self.emailTextField = UITextField()
        self.emailTextField.delegate = self
        self.emailTextField.layer.cornerRadius = 5
        self.emailTextField.alpha = 0.8
        self.passwordTextField = UITextField()
        self.passwordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.layer.cornerRadius = 5
        self.passwordTextField.alpha = 0.8
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        self.emailTextField.placeholder = "E-Mail"
        self.passwordTextField.placeholder = "Password"
        self.orLabel.text = "OR"
        self.orLabel.textAlignment = NSTextAlignment.center
        self.orLabel.isHidden = true
        
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.setTitleColor(.white, for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        self.signupButton.setTitle("Signup", for: .normal)
        self.signupButton.setTitleColor(.white, for: .normal)
        self.signupButton.addTarget(self, action: #selector(self.signupButtonTapped), for: .touchUpInside)
        
        self.continueWithoutLoginButton.setTitle("Continue without logging in.", for: UIControlState())
        self.continueWithoutLoginButton.titleLabel?.textColor = UIColor.white
        self.continueWithoutLoginButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 13.0)
        self.continueWithoutLoginButton.reversesTitleShadowWhenHighlighted = true
        self.continueWithoutLoginButton.setTitleColor(FlatMint(), for: .highlighted)
        self.continueWithoutLoginButton.addTarget(self, action: #selector(signInAsGenericUserTapped), for: .touchUpInside)
        
        self.view.addSubview(filterView)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signupButton)
        self.view.addSubview(self.orLabel)
        self.view.addSubview(self.continueWithoutLoginButton)
        
        self.viewsConstraints()
        
        let filePath = Bundle.main.path(forResource: "sparkTop2", ofType: "gif")
        let gif = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
        
        self.view.addSubview(webViewBG)
        self.webViewBG.translatesAutoresizingMaskIntoConstraints = false
        self.webViewBG.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.webViewBG.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.webViewBG.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.webViewBG.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        webViewBG.load(gif!, mimeType: "image/gif", textEncodingName: String(), baseURL: URL())
        webViewBG.isUserInteractionEnabled = false
        
        self.view.addSubview(careerSparkLabel)
        self.view.addSubview(careerSparkHeadlineLabel)
        
        
        self.filterView.translatesAutoresizingMaskIntoConstraints = false
        self.filterView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.filterView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.filterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.filterView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.filterView.backgroundColor = UIColor.flatBlack()
        self.view.sendSubview(toBack: filterView)
        self.filterView.alpha = 0.2
        
        self.careerSparkLabel.translatesAutoresizingMaskIntoConstraints = false
        self.careerSparkLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.careerSparkLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.careerSparkLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.careerSparkLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        self.careerSparkHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        self.careerSparkHeadlineLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.careerSparkHeadlineLabel.topAnchor.constraint(equalTo: self.careerSparkLabel.bottomAnchor).isActive = true
        self.careerSparkHeadlineLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.careerSparkHeadlineLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        
        careerSparkLabel.text = "CareerSpark"
        careerSparkLabel.textColor = UIColor.white
        careerSparkLabel.font = UIFont(name: FontName.TrebuchetMSBold, size: 44)
        careerSparkLabel.textAlignment = NSTextAlignment.center
        careerSparkLabel.adjustsFontSizeToFitWidth = true

        careerSparkHeadlineLabel.text = "Discover your new career."
        careerSparkHeadlineLabel.textColor = UIColor.white
        careerSparkHeadlineLabel.font = UIFont.pandaFontMedium(withSize: 20)
        careerSparkHeadlineLabel.textAlignment = NSTextAlignment.center
        self.view.sendSubview(toBack: webViewBG)
        
        self.view.backgroundColor = FlatBlueDark()
        self.emailTextField.backgroundColor = FlatWhite()
        self.passwordTextField.backgroundColor = FlatWhite()
        self.loginButton.colors = .init(button: FlatMintDark().darken(byPercentage: 0.1), shadow: FlatMintDark().darken(byPercentage: 0.2))
        self.loginButton.shadowHeight = 5
        self.loginButton.depth = 0.65
        self.loginButton.titleLabel!.font = UIFont.pandaFontLight(withSize: 20)
        self.signupButton.colors = .init(button: FlatMintDark().darken(byPercentage: 0.1), shadow: FlatMintDark().darken(byPercentage: 0.2))
        self.signupButton.shadowHeight = 5
        self.signupButton.depth = 0.65
        self.signupButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20)
        
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
        
        self.emailTextField.textAlignment = NSTextAlignment.center
        self.passwordTextField.textAlignment = NSTextAlignment.center
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.75)
            make.height.equalTo(self.view).multipliedBy(0.0935)
            make.centerY.equalTo(self.view).offset(-self.view.bounds.height*0.1)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.75)
            make.height.equalTo(self.view).multipliedBy(0.0935)
            make.centerY.equalTo(self.view)
        }
        
        self.orLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width).offset(40)
            make.height.equalTo(self.view
                
                
                
                
                .snp.height).offset(45)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(60)
        }
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:  self.view.bounds.height/6).isActive = true
        self.loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
        
        self.signupButton.translatesAutoresizingMaskIntoConstraints = false
        self.signupButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.signupButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.bounds.height/6).isActive = true
        self.signupButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier:  0.75).isActive = true
        self.signupButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier:  0.125).isActive = true
        
        self.continueWithoutLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.continueWithoutLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.continueWithoutLoginButton.widthAnchor.constraint(equalTo: self.loginButton.widthAnchor).isActive = true
        self.continueWithoutLoginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor).isActive = true
        self.continueWithoutLoginButton.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor).isActive = true
    }
    
    func signInAsGenericUserTapped() {
        
        let alert = Constants.displayAlertWithContinueAndCancel("Heads Up!", message: "Without logging in, you won't be able to save your answers to the survey or favorite any jobs. Would you like to continue?", continueHandler: { 
            // continueHandler
            
            FIRAuth.auth()?.signIn(withEmail: Secrets.genericUserEmail, password: Secrets.genericUserPassword, completion: { (user, error) in
                
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
        
        FIRAuth.auth()?.signIn(withEmail: userEmail, password: userPassword, completion: { (user, error) in
            
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
        
        FIRAuth.auth()?.createUser(withEmail: userEmail, password: userPassword, completion: { (user, error) in
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
