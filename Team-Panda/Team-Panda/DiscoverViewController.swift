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
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, detail : Bool) {
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
        self.tableView.backgroundColor = UIColor.flatForestGreenColor()
        self.tableView.registerClass(DiscoverTableViewCell.self, forCellReuseIdentifier: "discoverCell")
        
        self.navigationController?.navigationBar.topItem?.title = "Discover"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.pandaFontMedium(withSize: 18)]
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.opaque = false
        // Do any additional setup after loading the view.
        self.createViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViews() {
    
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.tableView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.tableView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.tableView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    }

}

extension DiscoverViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("discoverCell", forIndexPath: indexPath) as! DiscoverTableViewCell

        let jobSection =  store.jobDiscoverData[indexPath.section]
        let occupationTitle = jobSection[indexPath.row].occupation
        
        cell.setProperties(occupationTitle)
        cell.createViews()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.jobDiscoverData[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return store.jobDiscoverData.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return majorSOCcodes[store.sectionHeaders[section]]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
        let job = store.jobDiscoverData[indexPath.section][indexPath.row]
        
        SwiftSpinner.show("Loading Details")
        
        let socCode = Int(job.SOCcode)!
        
        let params = DataSeries.createSeriesIDsFromSOC([socCode], withDataType: DataSeries.annualMeanWage)
        
        DataStore.store.getSingleOccupationWithCompletion(params) { (job) in
            jobDetail.job = job
            self.navigationController?.showViewController(jobDetail, sender: "")
            self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
}
