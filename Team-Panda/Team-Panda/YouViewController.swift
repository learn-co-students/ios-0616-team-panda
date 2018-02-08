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
    
    private let youTableView = UITableView()
    private let reuseIdentifier = "youCell"
    private let store = DataStore.store
    var params = [String: Any]()
    lazy private var statusBarView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUpTableViewAndNavBar()
        SwiftSpinner.show("Loading your personalized results")
        getSavedJobChoices {
            SwiftSpinner.hide()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = .flatMint
    }
    
    private func settingUpTableViewAndNavBar() {
        youTableView.delegate = self
        youTableView.dataSource = self
        youTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        youTableView.backgroundColor = .flatMint
        youTableView.accessibilityLabel = "tableView"
        youTableView.accessibilityIdentifier = "tableView"
        
        view.addSubview(youTableView)
        
        youTableView.translatesAutoresizingMaskIntoConstraints = false
        youTableView.safeLeadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        youTableView.safeTrailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        youTableView.safeTopAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        youTableView.safeBottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true

        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.topItem?.title = "Career Results"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.pandaFontMedium(withSize: 18)]
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isOpaque = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.jobsResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = youTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let job = store.jobsResultsArray[indexPath.row]
        
        cell.textLabel?.text = job.occupation
        cell.textLabel?.font = UIFont.pandaFontLight(withSize: 16)
        cell.backgroundColor = .flatMint
        cell.textLabel?.adjustsFontSizeToFitWidth = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SwiftSpinner.show("Loading Details", animated: true)
        let jobDetail = JobDetailViewController()
        jobDetail.job = store.jobsResultsArray[indexPath.row]
        navigationController?.show(jobDetail, sender: "")
        youTableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getSavedJobChoices(_ completion: @escaping () -> ()) {
        if let currentPanda = store.tpUser {
            params = DataSeries.createSeriesIDsFromSOC(currentPanda.socCodes, withDataType: DataSeries.annualMeanWage)
        } else {
            print("Current user is nil when loading You from auto login.")
        }
        
        store.getMultipleOccupationsWithCompletion(params) { [weak self] job, error in
            if let error = error {
                let alert = Constants.displayAlertWith("Network Error", message: error.localizedDescription, actionLabel: "Try Again", style: .cancel, actionHandler: {})
                self?.present(alert, animated: true, completion: nil)
                completion()
            } else {
                print("Finished API call. Updating table view.")
                self?.youTableView.reloadData()
                completion()
            }
        }
    }
}
