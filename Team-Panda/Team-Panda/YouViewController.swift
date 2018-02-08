//
//  YouViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftSpinner

final class YouViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var youTableView = UITableView()
    let reuseIdentifier = "youCell"
    let store = DataStore.store
    var params : [String : Any] = [:]
    lazy var statusBarView : UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingUpTableViewAndNavBar()
        SwiftSpinner.show("Loading your personalized results")
        self.getSavedJobChoices {
            SwiftSpinner.hide()
        }
    }
    
    func settingUpTableViewAndNavBar() {
        
        self.youTableView.delegate = self
        self.youTableView.dataSource = self
        self.youTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.youTableView.backgroundColor = FlatMint()
        self.youTableView.accessibilityLabel = "tableView"
        self.youTableView.accessibilityIdentifier = "tableView"
        
        self.view.addSubview(self.youTableView)
        
        youTableView.translatesAutoresizingMaskIntoConstraints = false
        youTableView.safeLeadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        youTableView.safeTrailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        youTableView.safeTopAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        youTableView.safeBottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true

        self.navigationController?.navigationBar.topItem?.title = "Career Results"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.pandaFontMedium(withSize: 18)]
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.isOpaque = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.jobsResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.youTableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let job = store.jobsResultsArray[indexPath.row]
        
        cell.textLabel?.text = job.occupation
        cell.textLabel?.font = UIFont.pandaFontLight(withSize: 16)
        cell.backgroundColor = FlatMint()
        cell.textLabel?.adjustsFontSizeToFitWidth = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SwiftSpinner.show("Loading Details", animated: true)
        
        let jobDetail = JobDetailViewController()
        
        jobDetail.job = store.jobsResultsArray[indexPath.row]
        
        self.navigationController?.show(jobDetail, sender: "")
        
        self.youTableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func getSavedJobChoices(_ completion : @escaping () -> ()) {
        
        if let currentPanda = store.tpUser {
            self.params = DataSeries.createSeriesIDsFromSOC(currentPanda.socCodes, withDataType: DataSeries.annualMeanWage)
        } else {
            print("Current user is nil when loading You from auto login.")
        }
        
        self.store.getMultipleOccupationsWithCompletion(self.params) { job, error in
            
            if let error = error {
                
                let alert = Constants.displayAlertWith("Network Error", message: error.localizedDescription, actionLabel: "Try Again", style: .cancel, actionHandler: {})
                self.present(alert, animated: true, completion: nil)
                completion()
                
            } else {
                
                print("Finished API call. Updating table view.")
                self.youTableView.reloadData()
                completion()
            }
        }
    }
}
