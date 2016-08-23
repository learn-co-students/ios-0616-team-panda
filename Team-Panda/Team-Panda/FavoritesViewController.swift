//
//  FavoritesViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
import SwiftSpinner

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let store = DataStore.store
    
    var favoritesTableView : UITableView = UITableView()
    var favCell = "favCell"
    
    //
    lazy var jobData : [[Job]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        createTableViewConstraints()
        self.favoritesTableView.reloadData()
        self.favoritesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
       
        self.navigationController?.navigationBar.topItem?.title = "Favorites"
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.opaque = false
        print("Favorites Array: \(store.tpUser?.favoritesArray)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.favoritesTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let favorites = store.tpUser!.favoritesArray
        
        store.tpUser!.favoritesArray = favorites.filter({ (string) -> Bool in
            return string != "" ? true : false
        })
        
        return store.tpUser!.favoritesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = UITableViewCell(style: .Default, reuseIdentifier: "basicCell")
        
        //if store.tpUser!.favoritesArray[indexPath.row] != "" {
        cell1.textLabel?.text = getJobNameForSOCCode(store.tpUser!.favoritesArray[indexPath.row])
        cell1.textLabel?.adjustsFontSizeToFitWidth = false
        //}
        cell1.backgroundColor = UIColor.flatYellowColorDark()

        return cell1
    }
    
    func getJobNameForSOCCode(SOCCode: String) -> String {
        
        let prefix = SOCCode.substringToIndex(SOCCode.startIndex.advancedBy(2)) + "0000"
        var socJobName = String()
        
        if let unwrappedSocName = allSOCCodes[prefix]![SOCCode] {
            socJobName = unwrappedSocName
        }
        return socJobName
    }
    
    //shows Job Detail View Controller for selected job at indexpath
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
//        
//        //jobDetail.job! = store.tpUser?.favoritesArray[indexPath.row]
//        
//        self.navigationController?.showViewController(jobDetail, sender: "")
//        
//    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
//        
//        let job = self.jobData[indexPath][indexPath.row]
//        
//        SwiftSpinner.show("Getting data for\n\(job.occupation)")
//        
//        let socCode = Int(job.SOCcode)!
//        
//        let params = DataSeries.createSeriesIDsFromSOC([socCode], withDataType: DataSeries.annualMeanWage)
//        
//        DataStore.store.getSingleOccupationWithCompletion(params) { (job) in
//            jobDetail.job = job
//            self.navigationController?.showViewController(jobDetail, sender: "")
//            SwiftSpinner.hide()
//        }
//    }
    
    //Allows editing
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //Remove Jobs from saved job TableView
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let favoriteToDelete = self.store.tpUser?.favoritesArray.removeAtIndex(indexPath.row)
            self.favoritesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            store.tpUser?.updateDatabase()
            self.favoritesTableView.reloadData()
            
        } else if editingStyle == .Insert {
        }
    }
    
    //Creates constraints for tableView in ViewController
    func createTableViewConstraints() {
        self.view.addSubview(self.favoritesTableView)
        self.favoritesTableView.snp_makeConstraints { (make) in
            make.center.equalTo(self.view.snp_center)
            make.bottom.equalTo(self.view.snp_bottom)
            make.height.equalTo(self.view.snp_height)
            make.width.equalTo(self.view.snp_width)
        }
        
        self.favoritesTableView.backgroundColor = UIColor.flatYellowColorDark()
    }
    
}

