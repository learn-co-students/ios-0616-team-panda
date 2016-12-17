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
//import Former

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
    var topButton : PressableButton!
    var bottomButton : PressableButton!
    
    var tableView : UITableView!
    let interestsIdentifier = "interestsCell"
    let submitIdentifier = "submitCell"
    
    let maxCodes : Int = 50
    
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
        
        self.tableView.register(InterestsTableViewCell.self, forCellReuseIdentifier: interestsIdentifier)
        self.tableView.register(SubmitTableViewCell.self, forCellReuseIdentifier: submitIdentifier)
        
        self.view.backgroundColor = FlatRed()
        self.createViews()
    }
    
    func createViews() {
        
        self.titleTextLabel = UILabel()
        
        self.titleTextLabel.text = "Which of these interests you the most? (Select all that apply)"
        self.titleTextLabel.font = UIFont.pandaFontLight(withSize: 72.0)
        self.titleTextLabel.adjustsFontSizeToFitWidth = true
        self.titleTextLabel.numberOfLines = 2
        self.titleTextLabel.textColor = FlatWhite()
        self.titleTextLabel.textAlignment = .center
        
        self.view.addSubview(titleTextLabel)
        
        self.titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.titleTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.titleTextLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.titleTextLabel.bottomAnchor).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

/*
 *  TableView and Cell Delegate Functions
 */
extension WhichInterestsYouViewController : UITableViewDelegate, UITableViewDataSource, SubmitTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.interestsArray.count { // add submit button
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: submitIdentifier, for: indexPath) as! SubmitTableViewCell
            
            cell.delegate = self
            return cell
        }
        else {
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: interestsIdentifier, for: indexPath) as! InterestsTableViewCell
            
            cell.button.colors = .init(button: FlatRed(), shadow: FlatRedDark())
            
            cell.button.titleLabel?.textColor = FlatWhite()
            cell.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
            cell.button.setTitle(self.interestsArray[indexPath.row], for: .normal)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interestsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.bounds.size.height / CGFloat(self.interestsArray.count + 1)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func submitTapped(_ sender: AnyObject) {
        var numChecked = 0
        var i = 0
        while i < self.interestsArray.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? InterestsTableViewCell  {
                if cell.isChecked {
                    numChecked += 1
                }
            }
            i += 1
        }
        
        if numChecked == 0 {
            
            let alert = Constants.displayAlertWithTryAgain("Oops!", message: "Please select at least one interest!")
            self.show(alert, sender: "Try Again")
            return
        }
        
        print("Submit tapped in Interests!")
        
        var params : [String : Any] = [:]
        
        if let currentPanda = DataStore.store.tpUser {
            
            self.setUserAnswers(forUser: currentPanda)
            let SOCcodesArray = self.getNewJobs(forUser: currentPanda)
            
            currentPanda.socCodes.removeAll()
            currentPanda.socCodes = self.parseSOCCodes(SOCcodesArray)
            
            params = DataSeries.createSeriesIDsFromSOC(currentPanda.socCodes, withDataType: DataSeries.annualMeanWage)
            
            currentPanda.updateDatabase()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "tabBarController")
        
        if let youVC = tabBarVC.childViewControllers.first as? YouViewController {
            youVC.params = params
        }
        
        self.show(tabBarVC, sender: sender)
        
    }
    
    func setUserAnswers(forUser currentPanda : TPUser) {
        
        currentPanda.interestsAnswer.removeAll()
        
        var i = 0
        while i < self.interestsArray.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? InterestsTableViewCell  {
                if cell.isChecked {
                    currentPanda.interestsAnswer.append(self.interestsArray[i])
                }
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
        
        print("User: \(currentPanda.email) updated answers to questionaire: ")
        print("Tell us think or make: \(currentPanda.tellUsAnswer)")
        print("Would you rather style: \(currentPanda.wouldYouRatherAnswer)")
        print("Interests Answer: \(currentPanda.interestsAnswer)")
        
    }
    
    func getNewJobs(forUser currentPanda : TPUser) -> [[Int]] {
        
        var interestsCodes : [[Int]] = []
        
        if let interestsStyle = jobsDictionary[self.uiStyle] as? [String : [Int]] {
            
            for interest in currentPanda.interestsAnswer {
                
                if let interestCodeArray = interestsStyle[interest] {
                    
                    interestsCodes.append(interestCodeArray)
                }
            }
        }
        
        return interestsCodes
    }
    
    func parseSOCCodes(_ interestsCodes : [[Int]]) -> [Int] {
        
        let numberOfCodesPerInterest = self.maxCodes/interestsCodes.count
        
        var codes : [Int] = []
        
        for interests in interestsCodes {
            
            if interests.count <= numberOfCodesPerInterest {
                codes.append(contentsOf: interests)
            }
            else {
                var i = 0
                
                var chosenIndexes : [Int] = []
                
                while i < numberOfCodesPerInterest {
                    
                    let randomIndex = Int(arc4random_uniform(UInt32(numberOfCodesPerInterest)))
                    
                    if !chosenIndexes.contains(randomIndex) {
                        chosenIndexes.append(randomIndex)
                        codes.append(interests[randomIndex])
                        i += 1
                    }
                }
                //                print("The chosen indices for the codes array \(interests) are \(chosenIndexes)")
            }
        }
        return codes
    }
}
