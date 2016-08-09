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

class InterestsTableViewCell : UITableViewCell {
    
    var button : SwiftyButton
    var check : UIImage
    var checkedImageView : UIImageView
    
    var isChecked : Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.button = SwiftyButton()
        self.check = UIImage(named: "check.png")!
        self.checkedImageView = UIImageView(image: self.check)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.button = SwiftyButton()
        self.check = UIImage(named: "check.png")!
        self.checkedImageView = UIImageView(image: self.check)
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    func setupViews() {
        
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.90).active = true
        self.button.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.8).active = true
        self.button.rightAnchor.constraintEqualToAnchor(self.contentView.rightAnchor, constant: -5).active = true
        self.button.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        
        self.button.addTarget(self, action: #selector(didPressButton(_:)), forControlEvents: .TouchUpInside)
        
        self.contentView.addSubview(self.checkedImageView)
        self.checkedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.checkedImageView.leftAnchor.constraintEqualToAnchor(self.contentView.leftAnchor, constant: 2).active = true
        self.checkedImageView.rightAnchor.constraintEqualToAnchor(self.button.leftAnchor, constant: -2).active = true
        self.checkedImageView.heightAnchor.constraintEqualToAnchor(self.button.heightAnchor).active = true
        self.checkedImageView.centerYAnchor.constraintEqualToAnchor(self.button.centerYAnchor).active = true
        
        self.checkedImageView.hidden = true
    }
    
    func didPressButton(sender : SwiftyButton) {
        
        self.checkedImageView.hidden = self.isChecked ? true : false
        self.isChecked = !self.isChecked
    }
}
