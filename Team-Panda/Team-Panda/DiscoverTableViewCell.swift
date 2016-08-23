//
//  DiscoverTableViewCell.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import ChameleonFramework

class DiscoverTableViewCell: UITableViewCell {

    lazy var title : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createViews() {

        self.backgroundColor = FlatForestGreen()
        self.contentView.addSubview(self.title)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant:20.0).active = true
        self.title.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        self.title.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier:0.75).active = true

    }
    
    func setProperties(title : String) {
        
        self.title.text = title
        self.title.textColor = UIColor.whiteColor()
        self.title.font = UIFont.pandaFontLight(withSize: 16.0)
        self.title.textAlignment = .Left
    }

}
