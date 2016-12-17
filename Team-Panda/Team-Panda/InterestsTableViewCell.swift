//
//  InterestsTableViewCell.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftyButton

/*
 *  Custom table view cell for displaying interests and making them checkable
 */
class InterestsTableViewCell : UITableViewCell {
    
    var button : PressableButton
    var checkedImageView : UIImageView
    
    var isChecked : Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.button = PressableButton()
        self.checkedImageView = UIImageView(image: checkMarkImage)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.button = PressableButton()
        self.checkedImageView = UIImageView(image: checkMarkImage)
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    func setupViews() {
    
        self.button.colors = .init(button: FlatRed(), shadow: FlatRedDark())
        
        
        self.button.titleLabel?.textColor = FlatWhite()
        self.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.button.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.button.addTarget(self, action: #selector(didPressButton(_:)), for: .touchUpInside)
        
        
        self.contentView.addSubview(self.checkedImageView)
        
        self.checkedImageView.translatesAutoresizingMaskIntoConstraints = false
        self.checkedImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        self.checkedImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.checkedImageView.widthAnchor.constraint(equalTo: self.checkedImageView.heightAnchor).isActive = true
        
        let offset = 0.125/4*self.contentView.bounds.width
        
        self.checkedImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: offset).isActive = true
        
        self.checkedImageView.isHidden = true
    }
    
    func didPressButton(_ sender : PressableButton) {
        
        self.checkedImageView.isHidden = self.isChecked ? true : false
        self.isChecked = !self.isChecked
    }

}

protocol SubmitTableViewCellDelegate {
    func submitTapped(_ sender : AnyObject)
}

/*
 *  Custom Table View Cell for Submit Button
 */
class SubmitTableViewCell : UITableViewCell {
    
    var button : PressableButton
    var delegate : SubmitTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.button = PressableButton()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.button = PressableButton()
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    func setupViews() {
        
        self.button.titleLabel?.textColor = FlatWhite()
        self.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        
        self.button.colors = .init(button: FlatBlue(), shadow: FlatBlueDark())
        self.button.setTitle("Submit", for: .normal)
        
        
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6).isActive = true
        self.button.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        self.button.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
    }
    
    func submitButtonTapped(_ sender : PressableButton) {
        if let delegate = self.delegate {
            delegate.submitTapped(sender)
        }
        else {
            print("There is no functionality associated with the button. Did you set the delegate and implement submitButtonTapped?")
        }
    }
}
