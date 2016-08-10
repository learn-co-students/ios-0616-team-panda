//
//  SettingsViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import SwiftFontName

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView  =   UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.view.backgroundColor = UIColor.flatSkyBlueColor()
    }
    
    func setUpTableView() {
        tableView.frame = CGRectMake(0, 50, 320, 135);
        tableView.backgroundColor = UIColor.flatWhiteColor()
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
        self.view.addSubview(self.tableView)
        tableView.center = self.view.center
        tableView.layer.cornerRadius = 10
    }
    
    var settingsOptions = ["Update Profile Info", "Refresh Questionaire", "Log Out"]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.textLabel?.text = settingsOptions[indexPath.row]
        
        cell.textLabel?.font = UIFont.pandaFontLight(withSize: 20)
        
        cell.layer.cornerRadius = 5

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            print("Update Profile Info")
            self.presentViewController(UserProfileViewController(), animated: true, completion: nil)
            
        case 1:
            print("Refresh Questionaire")
            self.presentViewController(SignUpPageViewController(), animated: true, completion: nil)
            //Add logic to empty saved data
            
        case 2:
            print("Log Out")
            do{
                try FIRAuth.auth()?.signOut()
            }  catch {fatalError("Unable to log user out")}
            self.presentViewController(LoginViewController(), animated: true, completion: nil)
            
        default:
            print("Opps. Not Available")
        }
    }
    
}
