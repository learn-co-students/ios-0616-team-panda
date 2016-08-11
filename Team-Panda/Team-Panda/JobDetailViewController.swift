//
//  JobDetailViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

//import UIKit
//
//class JobDetailViewController: UIViewController {
//
//        var careerHeaderLabel = UILabel()
//        var careerDescriptionLabel = UILabel() //Should this be a UIText View?
//        var minEduReqsHeaderLabel = UILabel()
//        var minEduReqsDescriptionLabel = UILabel()
//        var salaryHeaderLabel = UILabel()
//        var salaryDescriptionLabel = UILabel() //Should be "$\(Int) to \(Int)"
//        var projectedGrowthNationalLabel = UILabel()
//        var projectedGrowthStateLabel = UILabel()
//        var projectedGrowthNatGraphUIImage = UIImage()
//        var projectedGrowthStGraphUIImage = UIImage()
//        var backButton = UIButton()
//        
//        let placeHolderState = "Idaho"
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            createViews()
//        }
//        
//        
//    
//    func createViews() {
//        
//        let topView = UIView()
//        topView.backgroundColor = UIColor.greenColor()
//        
//        let padding = UIEdgeInsetsMake(10, 10, 10, 10)
//        
//        self.view.addSubview(topView)
//        
//        topView.snp_makeConstraints { (make) in
//            make.edges.equalTo(self.view).offset(padding)
//        }
//        
//        
//        
//        self.minEduReqsHeaderLabel.text = "Minimum Education Requirements"
//        self.salaryHeaderLabel.text = "Salary Range"
//        self.projectedGrowthNationalLabel.text = "Demand for this role across the US"
//        self.projectedGrowthStateLabel.text = "Demand for this role in \(placeHolderState)"
//        
//        
//    }
//    
//    
//}
