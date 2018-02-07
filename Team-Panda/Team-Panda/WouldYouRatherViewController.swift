//
//  WouldYouRatherViewController.swift
//
//
//  Created by Salmaan Rizvi on 8/8/16.
//
//

import Foundation
import ChameleonFramework
import SwiftyButton

enum WouldYouRatherStyle : String {
    case Make = "Make"
    case Think = "Think"
    case Unknown = "Unknown"
}

class WouldYouRatherViewController : UIViewController {
    
    // UI Properties
    let uiStyle : WouldYouRatherStyle
    
    var titleTextLabel : UILabel!
    var curiosityTextLabel : UILabel!
    var topButton : PressableButton!
    var bottomButton : PressableButton!
    
    init(withUIStyle uiStyle : WouldYouRatherStyle) {
        self.uiStyle = uiStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.uiStyle = .Unknown
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createStandardViews()
        self.createViewsForStyle(self.uiStyle)
    }
    
    func buttonTapped(_ sender : PressableButton) {
        
        guard let signUpVC = self.parent as? SignUpPageViewController else { return }
        
        let nextVCStyle : WhichInterestsStyle
        
        switch sender {
        case topButton:
            
            switch self.uiStyle {
            case .Make:
                nextVCStyle = .SolveProblem
            default: // .Think
                nextVCStyle = .IdeaExpressed
            }
            
        default: // bottom button
            switch self.uiStyle {
            case .Make:
                nextVCStyle = .UnderstandProblem
            default: // .Think
                nextVCStyle = .IdeasFormed
                
            }
        }
        
        signUpVC.nextViewController(nextVCStyle)
        
    }
    
    /*
     *  Sets up all the UI buttons and labels with formatting and constraints
     */
    fileprivate func createStandardViews() {
        
        self.titleTextLabel = UILabel()
        
        self.titleTextLabel.text = "Tell us a little bit more about yourself"
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
        self.titleTextLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        
        
        self.curiosityTextLabel = UILabel()
        
        self.curiosityTextLabel.text = "Would you rather..."
        self.curiosityTextLabel.font = UIFont.pandaFontLight(withSize: 25.0)
        self.curiosityTextLabel.numberOfLines = 1
        self.curiosityTextLabel.adjustsFontSizeToFitWidth = true
        self.curiosityTextLabel.textColor = FlatWhite()
        self.curiosityTextLabel.textAlignment = .center
        
        self.view.addSubview(self.curiosityTextLabel)
        
        self.curiosityTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.curiosityTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.curiosityTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.curiosityTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.curiosityTextLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        
        
        self.topButton = PressableButton()
        
        self.view.addSubview(self.topButton)
        self.topButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.topButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.topButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.height/6).isActive = true
        self.topButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.topButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
        
        self.topButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        
        self.bottomButton = PressableButton()
        
        self.view.addSubview(self.bottomButton)
        self.bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomButton.translatesAutoresizingMaskIntoConstraints = false
        self.bottomButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.bottomButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.bounds.height/6).isActive = true
        self.bottomButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        self.bottomButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.125).isActive = true
        
        self.bottomButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    /*
     *  Setup based on style of view controller designated at initialization
     */
    fileprivate func createViewsForStyle(_ style : WouldYouRatherStyle) {
        
        // First button setup
        self.topButton.titleLabel?.numberOfLines = 2
        self.topButton.titleLabel?.textAlignment = .center
        self.topButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.topButton.shadowHeight = 5
        self.topButton.depth = 0.65
        self.topButton.cornerRadius = 5
        
        // Second button setup
        self.bottomButton.titleLabel?.numberOfLines = 2
        self.bottomButton.titleLabel?.textAlignment = .center
        self.bottomButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.bottomButton.shadowHeight = 5
        self.bottomButton.depth = 0.65
        self.bottomButton.cornerRadius = 5
        
        if self.uiStyle == .Make {
            
            self.view.backgroundColor = FlatMint()
            self.topButton.setTitle("Solve the problem at hand?", for: .normal)
            self.bottomButton.setTitle("Understand why the problem occured?", for: .normal)
            
            self.topButton.colors = .init(button: FlatPowderBlue(), shadow: FlatPowderBlueDark())
            
            self.topButton.titleLabel?.textColor = ContrastColorOf(FlatPowderBlue(), returnFlat: true)
            
            self.bottomButton.colors = .init(button: FlatPowderBlueDark(), shadow: FlatPowderBlueDark().darken(byPercentage: 0.2)!)
            self.bottomButton.titleLabel?.textColor = ContrastColorOf(FlatPowderBlueDark(), returnFlat: true)
            
        }
        else { // how people think
            
            self.view.backgroundColor = FlatMintDark()
            self.topButton.setTitle("Understand how ideas \nare expressed?", for: .normal)
            self.bottomButton.setTitle("Understand how ideas \nare formed?", for: .normal)
            
            self.topButton.colors = .init(button: FlatBlue(), shadow: FlatBlueDark())
            self.topButton.titleLabel?.textColor = ContrastColorOf(FlatBlue(), returnFlat: true)
            
            self.bottomButton.colors = .init(button: FlatBlueDark(), shadow: FlatBlueDark().darken(byPercentage: 0.2)!)
            self.bottomButton.titleLabel?.textColor = ContrastColorOf(FlatBlueDark(), returnFlat: true)
        }
    }
}
