//
//  LoginViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAndAddViews()
        self.textFieldConstraints()
    }
    
    @IBAction func submitTapped(sender: UIButton!) {
        print("Submit Tapped!")
    }
    
    func createAndAddViews() {
        
        self.usernameTextField = UITextField()
        self.usernameTextField.placeholder = "Username"
        self.passwordTextField = UITextField()
        self.passwordTextField.placeholder = "Password"
        
        let button = UIButton()
        button.setTitle("Submit", forState: .Normal)
        button.setTitleColor(.blueColor(), forState: .Normal)
        button.addTarget(self, action: #selector(self.submitTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        
        self.view.addSubview(self.usernameTextField)
        self.view.addSubview(self.passwordTextField)
        
        // button.backgroundColor = UIColor.brownColor()
        // self.usernameTextField.backgroundColor = UIColor.cyanColor()
        // self.passwordTextField.backgroundColor = UIColor.greenColor()
        
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
}