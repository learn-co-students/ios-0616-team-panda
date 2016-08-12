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

enum WhichInterestsStyle : String {
    case SolveProblem = "Solve Problem"
    case UnderstandProblem = "Understand Problem"
    case IdeaExpressed = "Idea Expressed"
    case IdeasFormed = "Ideas Formed"
    case Unknown = "Unknown"
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
    
    var interestsArray : [String] {
        if uiStyle == .SolveProblem || uiStyle == .UnderstandProblem { return solveProblemArray }
        else if uiStyle == .UnderstandProblem { return underStandProblemArray }
        else if uiStyle == .IdeaExpressed { return ideaExpressedArray }
        else if uiStyle == .IdeasFormed { return ideaFormedArray }
        else { return ["Try again"] }

    }
    
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
 *  TableView and Cell Delegate Functions
 */
extension WhichInterestsYouViewController : UITableViewDelegate, UITableViewDataSource, SubmitTableViewCellDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == self.interestsArray.count { // add submit button
        
           let cell = self.tableView.dequeueReusableCellWithIdentifier(submitIdentifier, forIndexPath: indexPath) as! SubmitTableViewCell
            
            cell.delegate = self
            return cell
        }
        else {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier(interestsIdentifier, forIndexPath: indexPath) as! InterestsTableViewCell
            
            cell.button.buttonColor = FlatRed()
            cell.button.shadowColor = FlatRedDark()
            
            cell.button.titleLabel?.textColor = FlatWhite()
            cell.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
            cell.button.setTitle(self.interestsArray[indexPath.row], forState: .Normal)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interestsArray.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.bounds.size.height / CGFloat(self.interestsArray.count)
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    /*********
        BUG: SUBMIT TAPPED ACTION DOESN'T ALWAYS CALL FUNCTION.
    **********/
    func submitTapped(sender: AnyObject) {
        
        print("Submit tapped in Interests!")
        
        if let currentPanda = DataStore.store.tpUser {
        
            currentPanda.interestsAnswer.removeAll()
            
            var i = 0
            while i < self.interestsArray.count {
                guard let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as? InterestsTableViewCell else { return }
                if cell.isChecked {
                    currentPanda.interestsAnswer.append(self.interestsArray[i])
                }
                i += 1
            }
            
            switch self.uiStyle {
            case .SolveProblem:
                currentPanda.tellUsAnswer = WouldYouRatherStyle.Make.rawValue
                currentPanda.wouldYouRatherAnswer = WhichInterestsStyle.SolveProblem.rawValue

            case .UnderstandProblem:
                currentPanda.tellUsAnswer = WouldYouRatherStyle.Make.rawValue
                currentPanda.wouldYouRatherAnswer = WhichInterestsStyle.UnderstandProblem.rawValue
            
            case .IdeaExpressed:
                currentPanda.tellUsAnswer = WouldYouRatherStyle.Think.rawValue
                currentPanda.wouldYouRatherAnswer = WhichInterestsStyle.IdeaExpressed.rawValue
            case .IdeasFormed:
                currentPanda.tellUsAnswer = WouldYouRatherStyle.Think.rawValue
                currentPanda.wouldYouRatherAnswer = WhichInterestsStyle.IdeasFormed.rawValue
                
            default: // Unknown answer
                currentPanda.tellUsAnswer = WouldYouRatherStyle.Unknown.rawValue
                currentPanda.wouldYouRatherAnswer = WhichInterestsStyle.Unknown.rawValue
            }
            
            print("Tell us think or make: \(currentPanda.tellUsAnswer)")
            print("Would you rather style: \(currentPanda.wouldYouRatherAnswer)")
            print("Interests Answer: \(currentPanda.interestsAnswer)")
            
            currentPanda.updateDatabase()
        } else {
            print("Unable to get current panda user.")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarVC = storyboard.instantiateViewControllerWithIdentifier("tabBarController")
        
        self.showViewController(tabBarVC, sender: sender)
        
    }
}
