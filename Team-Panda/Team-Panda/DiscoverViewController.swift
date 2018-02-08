//
//  DiscoverViewController.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SwiftSpinner

class DiscoverViewController: UIViewController {
    
    lazy var tableView : UITableView = UITableView()
    lazy var detail : Bool = false
    
    let store = DataStore.store
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, detail : Bool) {
        super.init(nibName: nil, bundle: nil)
        self.detail = detail
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.getJobDiscoverArray()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.flatForestGreen
        self.tableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: "discoverCell")
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.pandaFontMedium(withSize: 18)]
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.topItem?.title = "Discover"
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.createViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = .flatForestGreen
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViews() {
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}

extension DiscoverViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "discoverCell", for: indexPath) as! DiscoverTableViewCell
        
        let jobSection =  store.jobDiscoverData[indexPath.section]
        let occupationTitle = jobSection[indexPath.row].occupation
        
        cell.setProperties(occupationTitle)
        cell.createViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.jobDiscoverData[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return majorSOCcodes[store.sectionHeaders[section]]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
        let job = store.jobDiscoverData[indexPath.section][indexPath.row]
        
        SwiftSpinner.show("Loading Details")
        
        let socCode = Int(job.SOCcode)!
        
        let params = DataSeries.createSeriesIDsFromSOC([socCode], withDataType: DataSeries.annualMeanWage)
        
        DataStore.store.getSingleOccupationWithCompletion(params) { (job, error) in
            
            if let error = error {
                
                let alert = Constants.displayAlertWith("Network Error", message: error.localizedDescription, actionLabel: "Try Again", style: .cancel, actionHandler: {})
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                jobDetail.job = job
                self.navigationController?.show(jobDetail, sender: "")
                self.tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }
}
