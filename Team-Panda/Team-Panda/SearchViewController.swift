//
//  SearchViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchBar)
        searchBar.frame = CGRect(x: 0, y: 50, width: 320, height: 135);
        searchBar.center = self.view.center
    }
}
