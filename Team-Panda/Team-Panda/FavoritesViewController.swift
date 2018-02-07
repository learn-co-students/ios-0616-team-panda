//
//  FavoritesViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData
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
        self.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.navigationBar.isOpaque = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.favoritesTableView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = "Favorites"
        
        if store.tpUser!.uid == Secrets.genericUserUID {
            let alert = Constants.displayAlertWith("Oops!", message: "Viewing favorited jobs is only for logged in users. Go to Settings > Log Out and sign up to unlock full access to CareerSpark. It's free!", actionLabel: "Got it!", style: .default, actionHandler: { })
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let favorites = store.tpUser!.favoritesArray
        
        store.tpUser!.favoritesArray = favorites.filter({ (string) -> Bool in
            return string != "" ? true : false
        })
        
        return store.tpUser!.favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = UITableViewCell(style: .default, reuseIdentifier: "basicCell")
        
        cell1.textLabel?.text = getJobNameForSOCCode(store.tpUser!.favoritesArray[indexPath.row])
        cell1.textLabel?.font = UIFont.pandaFontLight(withSize: 16)
        cell1.textLabel?.adjustsFontSizeToFitWidth = false
        cell1.backgroundColor = UIColor.flatYellow
        
        return cell1
    }
    
    func getJobNameForSOCCode(_ SOCCode: String) -> String {
        
        let prefix = SOCCode.substring(to: SOCCode.characters.index(SOCCode.startIndex, offsetBy: 2)) + "0000"
        var socJobName = String()
        
        if let unwrappedSocName = allSOCCodes[prefix]![SOCCode] {
            socJobName = unwrappedSocName
        }
        return socJobName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
        let jobCode = store.tpUser!.favoritesArray[indexPath.row]
        
        SwiftSpinner.show("Loading Details")
        
        let socCode = Int(jobCode)!
        
        let params = DataSeries.createSeriesIDsFromSOC([socCode], withDataType: DataSeries.annualMeanWage)
        
        DataStore.store.getSingleOccupationWithCompletion(params) { (job, error) in
            
            if let error = error {
                
                let alert = Constants.displayAlertWith("Network Error", message: error.localizedDescription, actionLabel: "Try Again", style: .cancel, actionHandler: {})
                self.present(alert, animated: true, completion: nil)
            } else {
                
                jobDetail.job = job
                self.navigationController?.show(jobDetail, sender: "")
                self.favoritesTableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        if self.favoritesTableView.isEditing {
            self.favoritesTableView.setEditing(false, animated: true)
        } else {
            self.favoritesTableView.setEditing(true, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let _ = self.store.tpUser?.favoritesArray.remove(at: indexPath.row)
            self.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            store.tpUser?.updateDatabase()
            self.favoritesTableView.reloadData()
        }
        else if editingStyle == .insert {
        }
    }
    
    func createTableViewConstraints() {
        self.view.addSubview(self.favoritesTableView)
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editButtonTapped))
        self.navigationItem.rightBarButtonItem = editButton
        
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesTableView.safeLeadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        favoritesTableView.safeTrailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        favoritesTableView.safeTopAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        favoritesTableView.safeBottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true

        favoritesTableView.backgroundColor = UIColor.flatYellow
    }
}

