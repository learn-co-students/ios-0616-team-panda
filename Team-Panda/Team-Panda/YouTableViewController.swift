//
//  YouTableViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/12/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit

class YouTableViewController: UITableViewController {
    
    let store = DataStore.store
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        self.tableView.backgroundColor = UIColor.flatMintColor()
        store.getMultipleOccupationsWithCompletion {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.careerResultsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("youCell", forIndexPath: indexPath)
    
        cell.textLabel?.text = store.careerResultsArray[indexPath.row]
        cell.backgroundColor = UIColor.flatMintColor()
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }
}
