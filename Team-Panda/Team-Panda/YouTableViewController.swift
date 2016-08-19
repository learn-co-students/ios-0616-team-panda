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
    
    lazy var statusBarView : UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        self.tableView.backgroundColor = UIColor.flatMintColor()
        
        self.navigationController?.navigationBar.topItem?.title = "Your Career Results"
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.title = "Results"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = "⭐︎"
            
        SwiftSpinner.show("Loading your personalized results")
        self.getSavedJobChoices {
            SwiftSpinner.hide()
        }
        
        JSONParser().parsingJSON()
      //  ComparingCodes().sortingOccupationBySOCCode()

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
        
        jobDetail.job = store.jobsResultsArray[indexPath.row]
        
//        let selectedCode = store.jobsResultsArray[indexPath.row].SOCcode
        
//        store.getLocationQuotientforSOCCodeWithCompletion(selectedCode) { (lqDictionaryByState) in
//            print(lqDictionaryByState)
//            print("Completed.")
//        }
        
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
