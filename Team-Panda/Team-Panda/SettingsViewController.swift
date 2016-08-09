//
//  SettingsViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView  =   UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.view.backgroundColor = UIColor.blueColor()
    }
    
    func setUpTableView() {
        tableView.frame = CGRectMake(0, 50, 320, 200);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
        self.view.addSubview(self.tableView)
        tableView.center = self.view.center
        tableView.layer.cornerRadius = 10
    }
    
    var settingsOptions = ["Update Profile Info", "Log Out", "Switch User", "Refresh Questionaire"]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.textLabel?.text = settingsOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            print("Update Profile Info")
        case 1:
            print("Log Out")
        case 2:
            print("Switch User")
        case 3:
            print("Refresh Questionaire")
        default:
            print("Opps. Not Available")
        }
    }
    
}
