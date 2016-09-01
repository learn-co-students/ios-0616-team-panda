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
    var favoritesTableView = UITableView()
    var favCell = "favCell"

    lazy var jobData : [[Job]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        createTableViewConstraints()
        self.favoritesTableView.reloadData()
        self.favoritesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.opaque = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.favoritesTableView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = "Favorites"
        
        if store.tpUser!.uid == Secrets.genericUserUID {
            let alert = Constants.displayAlertWith("Oops!", message: "Viewing favorited jobs is only for logged in users. Go to Settings > Log Out and sign up to unlock full access to CareerSpark. It's free!", actionLabel: "Got it!", style: .Default, actionHandler: { })
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
        
        cell1.textLabel?.text = getJobNameForSOCCode(store.tpUser!.favoritesArray[indexPath.row])
        cell1.textLabel?.font = UIFont.pandaFontLight(withSize: 16)
        cell1.textLabel?.adjustsFontSizeToFitWidth = false
        cell1.backgroundColor = UIColor.flatYellowColor()
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
        let jobCode = store.tpUser!.favoritesArray[indexPath.row]
        
        SwiftSpinner.show("Loading Details")
        
        let socCode = Int(jobCode)!
        
        let params = DataSeries.createSeriesIDsFromSOC([socCode], withDataType: DataSeries.annualMeanWage)
        
        DataStore.store.getSingleOccupationWithCompletion(params) { (job, error) in
            
            if let error = error {
                
                let alert = Constants.displayAlertWith("Network Error", message: error.localizedDescription, actionLabel: "Try Again", style: .Cancel, actionHandler: {})
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                
                jobDetail.job = job
                self.navigationController?.showViewController(jobDetail, sender: "")
                self.favoritesTableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    @IBAction func editButtonTapped(sender: UIBarButtonItem) {
        
        if self.favoritesTableView.editing {
            self.favoritesTableView.setEditing(false, animated: true)
        } else {
            self.favoritesTableView.setEditing(true, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let favoriteToDelete = self.store.tpUser?.favoritesArray.removeAtIndex(indexPath.row)
            self.favoritesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            store.tpUser?.updateDatabase()
            self.favoritesTableView.reloadData()
        }
        else if editingStyle == .Insert {
        }
    }
    
    func createTableViewConstraints() {
        self.view.addSubview(self.favoritesTableView)
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(self.editButtonTapped))
        self.navigationItem.rightBarButtonItem = editButton
        self.favoritesTableView.snp_makeConstraints { (make) in
            make.center.equalTo(self.view.snp_center)
            make.bottom.equalTo(self.view.snp_bottom)
            make.height.equalTo(self.view.snp_height)
            make.width.equalTo(self.view.snp_width)
        }
        
        self.favoritesTableView.backgroundColor = UIColor.flatYellowColor()
    }
}

