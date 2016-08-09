//
//  SettingsViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    class SettingsTableView: UITableView {
        
        var settingsOptions = ["Update Profile Info", "Log Out", "Switch User", "Refresh Questionaire"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        // MARK: - Table view data source
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return settingsOptions.count
        }
        
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath) as UITableViewCell!
            
            cell.textLabel?.text = settingsOptions[indexPath.row]
            
            return cell
        }
        
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            //implementation here
        }
        
    }
    
}
