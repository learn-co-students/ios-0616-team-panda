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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createViews() {

        self.backgroundColor = FlatForestGreen()
        self.contentView.addSubview(self.title)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:20.0).isActive = true
        self.title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.title.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier:0.75).isActive = true

    }
    
    func setProperties(_ title : String) {
        
        self.title.text = title
        self.title.textColor = UIColor.white
        self.title.font = UIFont.pandaFontLight(withSize: 16.0)
        self.title.textAlignment = .left
    }

}
