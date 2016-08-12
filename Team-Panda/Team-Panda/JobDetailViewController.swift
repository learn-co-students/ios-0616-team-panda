
//  JobDetailViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.

import UIKit
import ChameleonFramework
import SnapKit
import SwiftFontName

class JobDetailViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var careerHeaderLabel = UILabel()
    var careerDescriptionLabel = UITextView()
    var minEduReqsHeaderLabel = UILabel()
    var minEduReqsDescriptionLabel = UILabel()
    var salaryHeaderLabel = UILabel()
    var salaryDescriptionLabel = UILabel() //Should be "$\(Int) to \(Int)"
    var locationQuotientLabel = UILabel()
    var locationQuotientUnitedStatesMapUIImageView = UIImageView()
    var backButton = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setStylingForViews()
        setTextForUILabels()
    }
    
    func createViews() {
        
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        
        let mapImage = UIImage(named: "DummyUSAMap")
        locationQuotientUnitedStatesMapUIImageView = UIImageView(image: mapImage)
        locationQuotientUnitedStatesMapUIImageView.backgroundColor = UIColor.cyanColor()
        //self.locationQuotientUnitedStatesMapUIImageView.sizeThatFits()
        self.locationQuotientUnitedStatesMapUIImageView.layer.masksToBounds = true
        self.locationQuotientUnitedStatesMapUIImageView.layer.cornerRadius = 10
        
        scrollView.addSubview(careerHeaderLabel)
        scrollView.addSubview(careerDescriptionLabel)
        scrollView.addSubview(minEduReqsHeaderLabel)
        scrollView.addSubview(minEduReqsDescriptionLabel)
        scrollView.addSubview(salaryHeaderLabel)
        scrollView.addSubview(salaryDescriptionLabel)
        scrollView.addSubview(locationQuotientLabel)
        scrollView.addSubview(locationQuotientUnitedStatesMapUIImageView)
        
        self.careerHeaderLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(40)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.height.equalTo(self.view).multipliedBy(0.1)
        }

        self.careerDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.careerHeaderLabel.bottomAnchor).offset(120)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.careerDescriptionLabel.sizeToFit()
        self.careerDescriptionLabel.scrollEnabled = false
        
        self.minEduReqsHeaderLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(330)
        }
        
        self.minEduReqsDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(360)
        }
        
        self.salaryHeaderLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(400)
        }
        
        self.salaryDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(430)
        }
        
        self.locationQuotientLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(470)
        }

        self.locationQuotientUnitedStatesMapUIImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(510)
        }

    }
    
    func setStylingForViews() {
        
        scrollView.backgroundColor = UIColor.flatGrayColor().lightenByPercentage(0.5)
        

        self.careerHeaderLabel.backgroundColor = UIColor.flatBlueColorDark()
        self.careerHeaderLabel.textAlignment = .Center
        self.careerHeaderLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.careerHeaderLabel.textColor = UIColor.flatWhiteColor()
        self.careerHeaderLabel.layer.masksToBounds = true
        self.careerHeaderLabel.layer.cornerRadius = 10
        
        self.careerDescriptionLabel.font = UIFont.pandaFontMedium(withSize: 16.0)
        self.careerDescriptionLabel.textColor = UIColor.flatWhiteColor()
        self.careerDescriptionLabel.backgroundColor = UIColor.flatBlueColorDark()
        self.careerDescriptionLabel.layer.masksToBounds = true
        self.careerDescriptionLabel.layer.cornerRadius = 10
        
        
        self.minEduReqsHeaderLabel.textAlignment = .Center
        self.minEduReqsHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.minEduReqsHeaderLabel.textColor = UIColor.flatBlueColorDark()
        
        self.minEduReqsDescriptionLabel.textAlignment = .Center
        self.minEduReqsDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.minEduReqsDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.salaryHeaderLabel.textAlignment = .Center
        self.salaryHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.salaryHeaderLabel.textColor = UIColor.flatBlueColorDark()
        
        self.salaryDescriptionLabel.textAlignment = .Center
        self.salaryDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.salaryDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.locationQuotientLabel.textAlignment = .Center
        self.locationQuotientLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.locationQuotientLabel.textColor = UIColor.flatBlueColorDark()
    }
    
    func setTextForUILabels() {
        
        minEduReqsHeaderLabel.text = "Minimum Education Requirements"
        salaryHeaderLabel.text = "Average Salary"
        locationQuotientLabel.text = "Demand for this role across the US"
        
        let careerHeaderPlaceholder = "Mobile Developer"
        let placeholderSalaryInt = 70000
        let placeholderEdReq = "Flatiron School"
        let placeholderCareerDescription = "Mobile App Developers are essentially the rock stars of the IT world. They are a fresh generation of techies. The profession is new – so the majority of people in the field are recent grads who taught themselves smartphone platforms in their university dorm. There is also a growing demographic of software developers who are applying their core development skills to transition into mobile application development."
        
        careerHeaderLabel.text = careerHeaderPlaceholder.uppercaseString
        careerDescriptionLabel.text = placeholderCareerDescription
        minEduReqsDescriptionLabel.text = placeholderEdReq
        salaryDescriptionLabel.text = "$\(placeholderSalaryInt)"
        
    }
    
    
}
