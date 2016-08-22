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

class FavoritesViewController: UIViewController{
    
    let store = DataStore.store
    var favorites: [Job] = []
    
    var favoritesTableView : UITableView = UITableView()
    var favCell = "favCell"
    
    //In DataStore --> Need a function to fetchData, to saveContext, and managedObjectContext
    
    //Add Constraints and add to View
    override func viewDidLoad() {
        
        super.viewDidLoad()
        createTableViewConstraints()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //store.fetchData()
        
    }
    
    //Creates number of cells
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.favoritesArray.count
    }
    
    //Assigns a saved job to each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.favoritesTableView.dequeueReusableCellWithIdentifier("favCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = store.favoritesArray[indexPath.row].occupation
        cell.backgroundColor = UIColor.flatYellowColor()
        cell.textLabel?.adjustsFontSizeToFitWidth = false
        
        return cell
    }
    
    //shows Job Detail View Controller for selected job at indexpath
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let jobDetail = JobDetailViewController(nibName: nil, bundle: nil)
        
        jobDetail.job = store.favoritesArray[indexPath.row]
        
        self.navigationController?.showViewController(jobDetail, sender: "")
        
    }
    
    //Allows editing
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //Remove Jobs from saved job TableView
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let favoriteToDelete = self.favorites.removeAtIndex(indexPath.row)
            
            //self.store.managedObjectContext.deleteObject(favoriteToDelete)
            
            //store.saveContext()
            
            self.favoritesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
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
    }
    
}

