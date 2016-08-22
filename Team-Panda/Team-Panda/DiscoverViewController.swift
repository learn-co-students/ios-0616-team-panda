//
//  DiscoverViewController.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    lazy var tableView : UITableView = UITableView()
    lazy var detail : Bool = false
    lazy var sectionHeaders : [String] = ["110000", "130000", "150000", "170000", "190000", "210000", "230000", "250000", "270000", "290000", "310000", "330000", "350000", "370000", "390000", "410000", "430000", "450000", "470000", "490000", "510000", "530000"]
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, detail : Bool) {
        super.init(nibName: nil, bundle: nil)
        self.detail = detail
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(DiscoverTableViewCell.self, forCellReuseIdentifier: "discoverCell")
        
        self.navigationController?.navigationBar.topItem?.title = "Discover"
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

        let sectionHeader = sectionHeaders[indexPath.section]
        let occupations = allSOCCodes[sectionHeader]!
        let occupationsArray = Array(occupations.values)
        let occupationTitle = occupationsArray[indexPath.row]
        
        cell.setProperties(occupationTitle)
        cell.createViews()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSOCCodes[sectionHeaders[section]]!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return majorSOCcodes[sectionHeaders[section]]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
//        let socCode : Int = allSOCCodes[sectionHeaders[indexPath.section]]
        
        let params = DataSeries.createSeriesIDsFromSOC([251021], withDataType: DataSeries.annualMeanWage)
        
        BLSAPIClient.getMultipleOccupationsWithCompletion(params) { (jobDictionary) in
            jobDetail.job = Job(withDictionary: jobDictionary as! [String : AnyObject])
            self.navigationController?.showViewController(jobDetail, sender: "")
        }
    }
}
