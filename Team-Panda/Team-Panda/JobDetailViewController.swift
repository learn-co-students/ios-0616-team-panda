
//  JobDetailViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.

import UIKit
import ChameleonFramework
import SnapKit
import SwiftFontName
import USStatesColorMap
import SwiftyButton
import CoreText

class JobDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var careerHeaderLabel = UILabel()
    var careerDescriptionLabel = UITextView()
    var minEduReqsHeaderLabel = UILabel()
    var minEduReqsDescriptionLabel = UILabel()
    var salaryHeaderLabel = UILabel()
    var salaryDescriptionLabel = UILabel()
    var locationQuotientLabel = UILabel()
    var locationQuotientUnitedStatesMapUIImageView = UIImageView()
    var entryLevelInfoButton = SwiftyButton()
    var payInfoButton = SwiftyButton()
    var locationQuotientInfoButton = SwiftyButton()
    var usaColorMapView: USStatesColorMap!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setStylingForViews()
        setTextForUILabels()
    }
    
    func createViews() {
        
        scrollView = UIScrollView(frame: view.bounds)
        self.scrollView.delegate = self
//        self.edgesForExtendedLayout = UIRectEdge.None
//        self.extendedLayoutIncludesOpaqueBars = false
        
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        
        scrollView.userInteractionEnabled = true
        scrollView.scrollEnabled = true
        
        scrollView.addSubview(careerHeaderLabel)
        scrollView.addSubview(careerDescriptionLabel)
        scrollView.addSubview(minEduReqsHeaderLabel)
        scrollView.addSubview(minEduReqsDescriptionLabel)
        scrollView.addSubview(salaryHeaderLabel)
        scrollView.addSubview(salaryDescriptionLabel)
        scrollView.addSubview(locationQuotientLabel)
        scrollView.addSubview(locationQuotientUnitedStatesMapUIImageView)
        scrollView.addSubview(entryLevelInfoButton)
        scrollView.addSubview(payInfoButton)
        scrollView.addSubview(locationQuotientInfoButton)
        
        self.view.addSubview(scrollView)
        
        self.usaColorMapView = USStatesColorMap(frame: CGRectMake(0, 0, self.scrollView.frame.width - 20, self.scrollView.frame.width - 20))
        self.usaColorMapView.setColorForAllStates(UIColor.flatRedColor())
        self.usaColorMapView.backgroundColor = UIColor.clearColor()
        
        self.usaColorMapView.performUpdates {
            self.usaColorMapView.setColor(UIColor.flatRedColor(), forState: Alabama)
            self.usaColorMapView.setColor(UIColor.flatBlueColor(), forState: Alaska)
            self.usaColorMapView.setColor(UIColor.flatGreenColor(), forState: California)
        }
        
        scrollView.addSubview(self.usaColorMapView)
        
        self.careerHeaderLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.scrollView).offset(40)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.height.equalTo(self.view).multipliedBy(0.1)
        }
        
        self.careerHeaderLabel.sizeToFit()
        self.careerHeaderLabel.adjustsFontSizeToFitWidth = true
        
        self.careerDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.careerHeaderLabel.bottomAnchor).offset(120)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.careerDescriptionLabel.allowsEditingTextAttributes = false
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
        
        self.entryLevelInfoButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.minEduReqsHeaderLabel.snp_rightMargin)
            make.centerY.equalTo(self.minEduReqsHeaderLabel.centerYAnchor)
        }
        
        self.entryLevelInfoButton.setTitle("?", forState: .Normal)
        self.entryLevelInfoButton.addTarget(self, action: #selector(entryLevelInfoButtonTapped), forControlEvents: .TouchUpInside)
        
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
        
        self.payInfoButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.salaryHeaderLabel.snp_rightMargin).offset(-20)
            make.centerY.equalTo(self.salaryHeaderLabel.centerYAnchor)
        }
        
        self.payInfoButton.setTitle("?", forState: .Normal)
        self.payInfoButton.addTarget(self, action: #selector(payInfoButtonTapped), forControlEvents: .TouchUpInside)
        
        self.locationQuotientLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(470)
        }
        
        self.usaColorMapView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.careerDescriptionLabel.bottomAnchor).offset(410)
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(self.view.snp_width)
        }
        
        self.locationQuotientInfoButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.salaryHeaderLabel.snp_rightMargin).offset(-40)
            make.centerY.equalTo(self.locationQuotientLabel.centerYAnchor)
        }
        
        self.locationQuotientInfoButton.setTitle("?", forState: .Normal)
        self.locationQuotientInfoButton.addTarget(self, action: #selector(locationQuotientButtonTapped), forControlEvents: .TouchUpInside)
    
        scrollView.contentSize = CGSizeMake(view.bounds.width, view.bounds.height + (self.careerDescriptionLabel.frame.height + self.usaColorMapView.frame.height + self.locationQuotientLabel.frame.height + self.careerHeaderLabel.frame.height + self.careerDescriptionLabel.frame.height))

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
        
        self.entryLevelInfoButton.titleLabel?.numberOfLines = 1
        self.entryLevelInfoButton.titleLabel?.textAlignment = .Center
        self.entryLevelInfoButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.entryLevelInfoButton.shadowHeight = 1
        self.entryLevelInfoButton.buttonPressDepth = 0.3
        self.entryLevelInfoButton.cornerRadius = 10
        self.entryLevelInfoButton.titleLabel?.textColor = FlatWhite()
        self.entryLevelInfoButton.buttonColor = FlatTeal()
        self.entryLevelInfoButton.shadowColor = FlatTeal().darkenByPercentage(0.2)
        
        self.minEduReqsDescriptionLabel.textAlignment = .Center
        self.minEduReqsDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.minEduReqsDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.salaryHeaderLabel.textAlignment = .Center
        self.salaryHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.salaryHeaderLabel.textColor = UIColor.flatBlueColorDark()
        
        self.salaryDescriptionLabel.textAlignment = .Center
        self.salaryDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.salaryDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.payInfoButton.titleLabel?.numberOfLines = 1
        self.payInfoButton.titleLabel?.textAlignment = .Center
        self.payInfoButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.payInfoButton.shadowHeight = 1
        self.payInfoButton.buttonPressDepth = 0.3
        self.payInfoButton.cornerRadius = 10
        self.payInfoButton.titleLabel?.textColor = FlatWhite()
        self.payInfoButton.buttonColor = FlatTeal()
        self.payInfoButton.shadowColor = FlatTeal().darkenByPercentage(0.2)
        
        self.locationQuotientLabel.textAlignment = .Center
        self.locationQuotientLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.locationQuotientLabel.textColor = UIColor.flatBlueColorDark()
        
        self.locationQuotientInfoButton.titleLabel?.numberOfLines = 1
        self.locationQuotientInfoButton.titleLabel?.textAlignment = .Center
        self.locationQuotientInfoButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.locationQuotientInfoButton.shadowHeight = 1
        self.locationQuotientInfoButton.buttonPressDepth = 0.3
        self.locationQuotientInfoButton.cornerRadius = 10
        self.locationQuotientInfoButton.titleLabel?.textColor = FlatWhite()
        self.locationQuotientInfoButton.buttonColor = FlatTeal()
        self.locationQuotientInfoButton.shadowColor = FlatTeal().darkenByPercentage(0.2)
    }
    
    func setTextForUILabels() {
        
        let careerHeaderPlaceholder = "Aerospace Engineering and Operations Technicians"
        let placeholderSalaryInt = 	66180
        let placeholderEdReq = "Associate's degree"
        let placeholderCareerDescription = "Aerospace engineering and operations technicians operate and maintain equipment used in developing, testing, and producing new aircraft and spacecraft. Increasingly, these workers are using computer-based modeling and simulation tools and processes in their work."
        
        minEduReqsHeaderLabel.text = "Typical Entry-Level Education"
        salaryHeaderLabel.text = "Median Pay"
        locationQuotientLabel.text = "Location Quotient"
        careerHeaderLabel.text = careerHeaderPlaceholder.uppercaseString
        careerDescriptionLabel.text = placeholderCareerDescription
        minEduReqsDescriptionLabel.text = placeholderEdReq
        salaryDescriptionLabel.text = "$\(placeholderSalaryInt)"
    }
    
    @IBAction func showEntryLevelAlert() {
        let alertController = UIAlertController(title: "Typical Entry-Level Education", message: "Typical level of education that most workers need to enter this occupation.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func entryLevelInfoButtonTapped(sender: UIButton!) {
        showEntryLevelAlert()
    }
    
    @IBAction func showPayAlert() {
        let alertController = UIAlertController(title: "Median Pay", message: "The wage at which half of the workers in the occupation earned more than that amount and half earned less. Median wage data are from the BLS Occupational Employment Statistics survey. In May 2015, the median annual wage for all workers was $36,200.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func payInfoButtonTapped(sender: UIButton!) {
        showPayAlert()
    }
    
    @IBAction func locationQuotientButtonAlert() {
        let alertController = UIAlertController(title: "Job Outlook", message: "The projected percent change in employment from 2014 to 2024. The average growth rate for all occupations is 7 percent.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func locationQuotientButtonTapped(sender: UIButton!) {
        locationQuotientButtonAlert()
    }
    
}
