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
import SwiftSpinner

class YouTableViewController: UITableViewController {
    
    let store = DataStore.store
    var params : [String : AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let top = self.parentViewController?.topLayoutGuide.length
                
        self.edgesForExtendedLayout = UIRectEdge.None
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.tableView.contentInset.top = top!
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        self.tableView.backgroundColor = UIColor.flatMintColor()
        
        self.navigationController?.navigationBar.topItem?.title = "Your Career Results"
        self.navigationController?.hidesBarsOnSwipe = true
        
        SwiftSpinner.show("Loading your personalized results")
        self.getSavedJobChoices {
            SwiftSpinner.hide()
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.jobsResultsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("youCell", forIndexPath: indexPath)
        
        let job = store.jobsResultsArray[indexPath.row]
        
        cell.textLabel?.text = job.occupation
        cell.backgroundColor = UIColor.flatMintColor()
        cell.textLabel?.adjustsFontSizeToFitWidth = false
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
        let selectedCode = store.jobsResultsArray[indexPath.row].SOCcode
        
        store.getLocationQuotientforSOCCodeWithCompletion(selectedCode) { (lqDictionaryByState) in
            print(lqDictionaryByState)
            print("Completed.")
        }
        
        self.navigationController?.showViewController(jobDetail, sender: "")

    }
    
    private func getSavedJobChoices(completion : () -> ()) {
        if let currentPanda = store.tpUser {
            
            self.params = DataSeries.createSeriesIDsFromSOC(currentPanda.socCodes, withDataType: DataSeries.annualMeanWage)
            
        } else { print("Current user is nil when loading You from auto login.") }
        
        print("Parameters for API Call: \(self.params)")
                
        self.store.getMultipleOccupationsWithCompletion(self.params) {
            
            print("Finished API call. Updating table view.")
            self.tableView.reloadData()
            completion()
        }
    }
    
}
