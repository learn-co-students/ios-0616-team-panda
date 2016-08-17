
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
    var minEduReqsInfoButton = SwiftyButton()
    var salaryInfoButton = SwiftyButton()
    var locationQuotientInfoButton = SwiftyButton()
    var usaColorMapView: USStatesColorMap!
    var howToBecomeOneLabel = UILabel()
    var howToBecomeOneDescription = UITextView()
    var howToBecomeOneView = UIView()
    
    var dummyDictionaryLocationQuotient = ["District of Columbia" : 1.81,
                                           "Colorado" : 1.55,
                                           "Delaware" : 1.44,
                                           "New York" : 1.27,
                                           "Virginia" : 1.21,
                                           "Maryland" : 1.18,
                                           "South Dakota" : 1.18,
                                           "Massachusetts" : 1.16,
                                           "Texas" : 1.14,
                                           "Minnesota" : 1.08,
                                           "New Jersey" : 1.08,
                                           "Pennsylvania" : 1.08,
                                           "Florida" : 1.07,
                                           "Nebraska" : 1.07,
                                           "Vermont" : 1.07,
                                           "Oklahoma" : 1.06,
                                           "Rhode Island" : 1.06,
                                           "California" : 1.05,
                                           "Connecticut" : 1.05,
                                           "Georgia" : 1.03,
                                           "North Dakota" : 0.98,
                                           "Washington" : 0.98,
                                           "Kansas" : 0.95,
                                           "Illinois" : 0.94,
                                           "Missouri" : 0.94,
                                           "New Mexico" : 0.9,
                                           "Alabama" : 0.89,
                                           "Hawaii" : 0.89,
                                           "Utah" : 0.89,
                                           "Arizona" : 0.87,
                                           "Ohio" : 0.87,
                                           "South Carolina" : 0.84,
                                           "North Carolina" : 0.83,
                                           "Wisconsin" : 0.82,
                                           "Alaska" : 0.81,
                                           "Maine" : 0.81,
                                           "New Hampshire" : 0.79,
                                           "Indiana" : 0.78,
                                           "Montana" : 0.77,
                                           "Oregon" : 0.76,
                                           "Michigan" : 0.75,
                                           "Wyoming" : 0.73,
                                           "Iowa" : 0.71,
                                           "Kentucky" : 0.71,
                                           "Nevada" : 0.71,
                                           "Idaho" : 0.68,
                                           "Louisiana" : 0.67,
                                           "Tennessee" : 0.67,
                                           "West Virginia" : 0.64,
                                           "Mississippi" : 0.55,
                                           "Arkansas" : 0.54]
    
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
        scrollView.addSubview(locationQuotientUnitedStatesMapUIImageView)
        scrollView.addSubview(salaryHeaderLabel)
        scrollView.addSubview(salaryDescriptionLabel)
        scrollView.addSubview(locationQuotientLabel)
        scrollView.addSubview(minEduReqsInfoButton)
        scrollView.addSubview(salaryInfoButton)
        scrollView.addSubview(locationQuotientInfoButton)
        scrollView.addSubview(howToBecomeOneView)
        
        self.howToBecomeOneView.addSubview(howToBecomeOneLabel)
        self.howToBecomeOneView.addSubview(howToBecomeOneDescription)
        
        self.view.addSubview(scrollView)
        
        self.usaColorMapView = USStatesColorMap(frame: CGRectMake(0, 0, self.scrollView.frame.width - 20, self.scrollView.frame.width - 20))
        
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
            make.top.equalTo(self.careerDescriptionLabel.snp_bottom).offset(30)
        }
        
        self.minEduReqsDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.minEduReqsHeaderLabel.snp_bottom).offset(10)
        }
        
        self.minEduReqsInfoButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.minEduReqsHeaderLabel.snp_right).offset(-50)
            make.top.equalTo(self.careerDescriptionLabel.snp_bottom).offset(30)
        }
        
        self.minEduReqsInfoButton.setTitle("?", forState: .Normal)
        self.minEduReqsInfoButton.addTarget(self, action: #selector(minEduReqsInfoButtonTapped), forControlEvents: .TouchUpInside)
        
        self.salaryHeaderLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.minEduReqsDescriptionLabel.snp_bottom).offset(20)
        }
        
        self.salaryDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.salaryHeaderLabel.snp_bottom).offset(10)
        }
        
        self.salaryInfoButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.salaryHeaderLabel).offset(70)
            make.top.equalTo(self.minEduReqsDescriptionLabel.snp_bottom).offset(20)
        }
        
        self.salaryInfoButton.setTitle("?", forState: .Normal)
        self.salaryInfoButton.addTarget(self, action: #selector(payInfoButtonTapped), forControlEvents: .TouchUpInside)
        
        self.locationQuotientLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.salaryDescriptionLabel.snp_bottom).offset(20)
        }
        
        self.usaColorMapView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.locationQuotientLabel.snp_bottom).offset(-80)
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(self.view.snp_width)
        }
        
        self.locationQuotientInfoButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.locationQuotientLabel.snp_right).offset(-100)
            make.top.equalTo(self.salaryDescriptionLabel.snp_bottom).offset(20)
        }
        
        self.howToBecomeOneView.snp_makeConstraints { (make) in
            make.top.equalTo(usaColorMapView.snp_bottomMargin).offset(20)
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(self.view.snp_width)
        }
        
        self.howToBecomeOneLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.howToBecomeOneView.snp_topMargin).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.howToBecomeOneDescription.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.howToBecomeOneLabel.snp_bottomMargin).offset(10)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.howToBecomeOneDescription.allowsEditingTextAttributes = false
        self.howToBecomeOneDescription.sizeToFit()
        self.howToBecomeOneDescription.scrollEnabled = false
        
        self.locationQuotientInfoButton.setTitle("?", forState: .Normal)
        self.locationQuotientInfoButton.addTarget(self, action: #selector(locationQuotientButtonTapped), forControlEvents: .TouchUpInside)
        
        scrollView.contentSize = CGSizeMake(view.bounds.width, view.bounds.height + (self.careerDescriptionLabel.frame.height + self.usaColorMapView.frame.height))
        
        setLocationQuotientMap(dummyDictionaryLocationQuotient)
    }
    
    func setLocationQuotientMap(dictionary: [String : Double]) {
        
        self.usaColorMapView.backgroundColor = UIColor.clearColor()
        self.usaColorMapView.setColorForAllStates(UIColor.flatGrayColor())
        self.usaColorMapView.performUpdates {
            
            for (state, locationQuotient) in dictionary {
                
                switch locationQuotient {
                    
                case 0.20..<0.40 :
                    self.usaColorMapView.setColor(UIColor.flatWatermelonColorDark(), forStateByName: state)
                    
                case 0.4..<0.8 :
                    self.usaColorMapView.setColor(UIColor.flatRedColor(), forStateByName: state)
                    
                case 0.8..<1.25 :
                    self.usaColorMapView.setColor(UIColor.flatRedColorDark(), forStateByName: state)
                    
                case 1.25..<2.50 :
                    self.usaColorMapView.setColor(UIColor.flatMaroonColor(), forStateByName: state)
                    
                case 2.50..<3.50 :
                    self.usaColorMapView.setColor(UIColor.flatBrownColor(), forStateByName: state)
                    
                default:
                    self.usaColorMapView.setColor(UIColor.flatGrayColor(), forStateByName: state)
                    print("No location quotient for \(state)")
                }
            }
        }
    }
    
    func setStylingForViews() {
        
        scrollView.backgroundColor = UIColor.flatYellowColorDark()
        
        self.careerHeaderLabel.backgroundColor = UIColor.flatYellowColorDark()
        self.careerHeaderLabel.textAlignment = .Center
        self.careerHeaderLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.careerHeaderLabel.textColor = UIColor.flatWhiteColor()
        //self.careerHeaderLabel.layer.masksToBounds = true
        //self.careerHeaderLabel.layer.cornerRadius = 10
        
        self.careerDescriptionLabel.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.careerDescriptionLabel.textColor = UIColor.flatWhiteColor()
        self.careerDescriptionLabel.backgroundColor = UIColor.flatYellowColorDark()
        self.careerDescriptionLabel.layer.masksToBounds = true
        self.careerDescriptionLabel.layer.cornerRadius = 10
        
        self.minEduReqsHeaderLabel.textAlignment = .Center
        self.minEduReqsHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.minEduReqsHeaderLabel.textColor = UIColor.flatBlueColorDark()
        
        self.minEduReqsInfoButton.titleLabel?.numberOfLines = 1
        self.minEduReqsInfoButton.titleLabel?.textAlignment = .Center
        self.minEduReqsInfoButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.minEduReqsInfoButton.shadowHeight = 1
        self.minEduReqsInfoButton.buttonPressDepth = 0.3
        self.minEduReqsInfoButton.cornerRadius = 10
        self.minEduReqsInfoButton.titleLabel?.textColor = FlatWhite()
        self.minEduReqsInfoButton.buttonColor = FlatTeal()
        self.minEduReqsInfoButton.shadowColor = FlatTeal().darkenByPercentage(0.2)
        
        self.minEduReqsDescriptionLabel.textAlignment = .Center
        self.minEduReqsDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.minEduReqsDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.salaryHeaderLabel.textAlignment = .Center
        self.salaryHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.salaryHeaderLabel.textColor = UIColor.flatBlueColorDark()
        
        self.salaryDescriptionLabel.textAlignment = .Center
        self.salaryDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.salaryDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.salaryInfoButton.titleLabel?.numberOfLines = 1
        self.salaryInfoButton.titleLabel?.textAlignment = .Center
        self.salaryInfoButton.titleLabel?.font = UIFont.pandaFontLight(withSize: 20.0)
        self.salaryInfoButton.shadowHeight = 1
        self.salaryInfoButton.buttonPressDepth = 0.3
        self.salaryInfoButton.cornerRadius = 10
        self.salaryInfoButton.titleLabel?.textColor = FlatWhite()
        self.salaryInfoButton.buttonColor = FlatTeal()
        self.salaryInfoButton.shadowColor = FlatTeal().darkenByPercentage(0.2)
        
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
        self.locationQuotientInfoButton.buttonColor = FlatMint()
        self.locationQuotientInfoButton.shadowColor = FlatMint().darkenByPercentage(0.2)
        
        self.howToBecomeOneView.backgroundColor = UIColor.flatPlumColor()
        
        self.howToBecomeOneLabel.textAlignment = .Center
        self.howToBecomeOneLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.howToBecomeOneLabel.textColor = UIColor.flatWhiteColor()
        
        self.howToBecomeOneDescription.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.howToBecomeOneDescription.textColor = UIColor.flatWhiteColor()
        self.howToBecomeOneDescription.backgroundColor = UIColor.flatPlumColor()

    }
    
    func setTextForUILabels() {
        
        let careerHeaderPlaceholder = "Operations Technicians"
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
        howToBecomeOneLabel.text = "How to Become One".uppercaseString
        howToBecomeOneDescription.text = "Although employers prefer to hire applicants with a master’s degree or Ph.D., entry-level positions are available for those with a bachelor’s degree. Analysts typically have a degree in operations research, management science, analytics, math, engineering, computer science, or another technical or quantitative field."
    }
    
    @IBAction func showMinEduReqsAlert() {
        let alertController = UIAlertController(title: "Typical Entry-Level Education", message: "Typical level of education that most workers need to enter this occupation.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func minEduReqsInfoButtonTapped(sender: UIButton!) {
        showMinEduReqsAlert()
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
        let alertController = UIAlertController(title: "Location Quotient", message: "The location quotient is the ratio of the area concentration of occupational employment to the national average concentration. A location quotient greater than one indicates the occupation has a higher share of employment than average, and a location quotient less than one indicates the occupation is less prevalent in the area than average.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func locationQuotientButtonTapped(sender: UIButton!) {
        locationQuotientButtonAlert()
    }
    
}
