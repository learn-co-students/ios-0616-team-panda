//
//  WhichInterestsYouViewController.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import ChameleonFramework
import SwiftyButton
import Former

enum WhichInterestsStyle {
    case SolveProblem
    case UnderstandProblem
    case IdeaExpressed
    case IdeasFormed
    case Unknown
}

class WhichInterestsYouViewController : UIViewController {
    
    // UI Properties
    let uiStyle : WhichInterestsStyle
    
    var titleTextLabel : UILabel!
    var topButton : SwiftyButton!
    var bottomButton : SwiftyButton!
    
    var tableView : UITableView!
    let interestsIdentifier = "interestsCell"
    let submitIdentifier = "submitCell"
    
    init(withUIStyle uiStyle : WhichInterestsStyle) {
        self.uiStyle = uiStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.uiStyle = .Unknown
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(InterestsTableViewCell.self, forCellReuseIdentifier: interestsIdentifier)
        self.tableView.registerClass(SubmitTableViewCell.self, forCellReuseIdentifier: submitIdentifier)
        
        self.view.backgroundColor = FlatRed()
        self.createViews()
    }
    

    func createViews() {
        
        self.titleTextLabel = UILabel()
        
        self.titleTextLabel.text = "Which of these interests you the most?"
        self.titleTextLabel.font = UIFont.pandaFontLight(withSize: 72.0)
        self.titleTextLabel.adjustsFontSizeToFitWidth = true
        self.titleTextLabel.numberOfLines = 2
        self.titleTextLabel.textColor = FlatWhite()
        self.titleTextLabel.textAlignment = .Center
        
        self.view.addSubview(titleTextLabel)
        
        self.titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.titleTextLabel.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.titleTextLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.titleTextLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.15).active = true
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraintEqualToAnchor(self.titleTextLabel.bottomAnchor).active = true
        self.tableView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.tableView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    }
    
}


/*
 *  FormViewController implementation
 */
extension WhichInterestsYouViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 9 { // equal to last cell 
        
           let cell = self.tableView.dequeueReusableCellWithIdentifier(submitIdentifier, forIndexPath: indexPath) as! SubmitTableViewCell
            return cell
        }
        else {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier(interestsIdentifier, forIndexPath: indexPath) as! InterestsTableViewCell
            
            cell.button.buttonColor = FlatRed()
            cell.button.shadowColor = FlatRedDark()
            
            cell.button.titleLabel?.textColor = FlatWhite()
            cell.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
            cell.button.setTitle("Testing", forState: .Normal)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}
