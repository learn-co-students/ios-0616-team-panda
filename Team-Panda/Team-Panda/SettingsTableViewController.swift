//
//  SettingsTableViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//


import UIKit

class SettingsTableViewController: UITableViewController {
    
    var settingsOptions = ["Reset", "Log Out", "Switch User", "Refresh Questionaire"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 60
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            assert(false, "section \(section)")
            return 0
        }
}
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Career Settings"
        case 1:
            return "User Settings"
        default:
            assert(false, "section \(section)")
            return "Did not work"
        }
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