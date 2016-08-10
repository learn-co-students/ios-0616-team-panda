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
    
    var button : SwiftyButton
    var checkedImageView : UIImageView
    
    var isChecked : Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.button = SwiftyButton()
        self.checkedImageView = UIImageView(image: checkMarkImage)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.button = SwiftyButton()
        self.checkedImageView = UIImageView(image: checkMarkImage)
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    func setupViews() {
    
        self.button.buttonColor = FlatRed()
        self.button.shadowColor = FlatRedDark()
        
        self.button.titleLabel?.textColor = FlatWhite()
        self.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.8).active = true
        self.button.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.75).active = true
        self.button.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        self.button.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
        self.button.addTarget(self, action: #selector(didPressButton(_:)), forControlEvents: .TouchUpInside)
        
        
        self.contentView.addSubview(self.checkedImageView)
        
        self.checkedImageView.translatesAutoresizingMaskIntoConstraints = false
        self.checkedImageView.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.5).active = true
        self.checkedImageView.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        self.checkedImageView.widthAnchor.constraintEqualToAnchor(self.checkedImageView.heightAnchor).active = true
        
        let offset = 0.125/4*self.contentView.bounds.width
        
        self.checkedImageView.leftAnchor.constraintEqualToAnchor(self.contentView.leftAnchor, constant: offset).active = true
        
        self.checkedImageView.hidden = true
    }
    
    func didPressButton(sender : SwiftyButton) {
        
        self.checkedImageView.hidden = self.isChecked ? true : false
        self.isChecked = !self.isChecked
    }

}

/*
 *  Custom Table View Cell for Submit Button
 */
class SubmitTableViewCell : UITableViewCell {
    
    var button : SwiftyButton
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.button = SwiftyButton()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.button = SwiftyButton()
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    func setupViews() {
        
        self.button.titleLabel?.textColor = FlatWhite()
        self.button.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        
        self.button.buttonColor = FlatBlue()
        self.button.shadowColor = FlatBlueDark()
        
        self.button.setTitle("Submit", forState: .Normal)

        
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.6).active = true
        self.button.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.8).active = true
        self.button.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        self.button.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
        
        self.button.addTarget(self, action: #selector(submitButtonTapped(_:)), forControlEvents: .TouchUpInside)
    }
    
    func submitButtonTapped(sender : SwiftyButton) {
        
        print("This should finish the questionaire!")
        
    }
}
