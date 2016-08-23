//
//  YouViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit
import SwiftSpinner

class YouViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var youTableView = UITableView()
    let reuseIdentifier = "youCell"
    let store = DataStore.store
    var params : [String : AnyObject] = [:]
    lazy var statusBarView : UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingUpTableViewAndNavBar()
        SwiftSpinner.show("Loading your personalized results")
        self.getSavedJobChoices {
            SwiftSpinner.hide()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Your Career Results"
    }
    
    func settingUpTableViewAndNavBar() {
        
        self.youTableView.delegate = self
        self.youTableView.dataSource = self
        self.youTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.youTableView.accessibilityLabel = "tableView"
        self.youTableView.accessibilityIdentifier = "tableView"
        
        self.view.addSubview(self.youTableView)
        self.youTableView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        self.navigationController?.navigationBar.topItem?.title = "Your Career Results"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.pandaFontMedium(withSize: 18)]
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.opaque = false
        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.title = "Results"
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.jobsResultsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.youTableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath)
        let job = store.jobsResultsArray[indexPath.row]
        
        cell.textLabel?.text = job.occupation
        cell.textLabel?.font = UIFont.pandaFontLight(withSize: 16)
        cell.backgroundColor = UIColor.flatMintColor()
        cell.textLabel?.adjustsFontSizeToFitWidth = false
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
        } else {
            print("Current user is nil when loading You from auto login.")
        }
        
        self.store.getMultipleOccupationsWithCompletion(self.params) {
            
            print("Finished API call. Updating table view.")
            self.youTableView.reloadData()
            completion()
        }
    }
}