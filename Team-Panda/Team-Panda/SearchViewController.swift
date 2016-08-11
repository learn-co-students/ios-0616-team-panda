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
        searchBar.frame = CGRectMake(0, 50, 320, 135);
        searchBar.center = self.view.center
    }
}
