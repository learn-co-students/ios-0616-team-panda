
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
    
    var store = DataStore.store
    var job : Job?
    var scrollView = UIScrollView()
    var careerHeaderLabel = UILabel()
    var careerDescriptionLabel = UITextView()
    var minEduReqsHeaderLabel = UILabel()
    var minEduReqsDescriptionLabel = UILabel()
    var salaryHeaderLabel = UILabel()
    var salaryDescriptionLabel = UILabel()
    var locationQuotientLabel = UILabel()
    var locationQuotientUnitedStatesMapUIImageView = UIImageView()
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
        store.getLocationQuotientforSOCCodeWithCompletion(job!.SOCcode) { (lqDictionaryByState) in
            self.setLocationQuotientMap(lqDictionaryByState)
            print(lqDictionaryByState)
            print("Completed.")
        }
        
    }
    
    func createViews() {
        
        scrollView = UIScrollView(frame: view.bounds)
        self.scrollView.delegate = self
        self.edgesForExtendedLayout = UIRectEdge.None
        self.extendedLayoutIncludesOpaqueBars = false
        
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
        scrollView.addSubview(howToBecomeOneView)
        
        self.howToBecomeOneView.addSubview(howToBecomeOneLabel)
        self.howToBecomeOneView.addSubview(howToBecomeOneDescription)
        
        self.view.addSubview(scrollView)
        self.usaColorMapView = USStatesColorMap(frame: CGRectMake(0, 0, self.scrollView.frame.width - 20, self.scrollView.frame.width - 20))
        scrollView.addSubview(self.usaColorMapView)
        self.scrollView.bringSubviewToFront(locationQuotientLabel)
        
        self.careerHeaderLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.scrollView)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.2)
        }
        
        self.careerHeaderLabel.sizeToFit()
        self.careerHeaderLabel.adjustsFontSizeToFitWidth = true
        
        self.careerDescriptionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.careerHeaderLabel.snp_bottom).offset(self.careerHeaderLabel.frame.height * 6)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.careerDescriptionLabel.editable = false
        self.careerDescriptionLabel.selectable = false
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

        self.locationQuotientLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.salaryDescriptionLabel.snp_bottom).offset(20)
        }
        
        self.usaColorMapView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.locationQuotientLabel.snp_bottom).offset(-70)
            make.width.equalTo(self.view.snp_width).multipliedBy(0.9)
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
        
        self.howToBecomeOneView.snp_makeConstraints { (make) in
            make.top.equalTo(usaColorMapView.snp_bottomMargin).offset(10)
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(self.howToBecomeOneDescription.snp_height)
        }
        
        self.howToBecomeOneDescription.editable = false
        self.howToBecomeOneDescription.selectable = false
        self.howToBecomeOneDescription.sizeToFit()
        self.howToBecomeOneDescription.scrollEnabled = false
        
        scrollView.snp_makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide)
        }
        
        scrollView.contentSize = CGSizeMake(view.bounds.width, (view.bounds.height * 1.2) + (self.careerDescriptionLabel.frame.height + self.usaColorMapView.frame.height + self.howToBecomeOneDescription.frame.height))
        
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
        
        scrollView.backgroundColor = UIColor.flatWhiteColor()
        
        self.careerHeaderLabel.backgroundColor = UIColor.flatMintColorDark()
        self.careerHeaderLabel.textAlignment = .Center
        self.careerHeaderLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.careerHeaderLabel.textColor = UIColor.flatWhiteColor()
        self.careerHeaderLabel.layer.masksToBounds = true
        
        self.careerDescriptionLabel.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.careerDescriptionLabel.textColor = UIColor.flatMintColorDark()
        self.careerDescriptionLabel.backgroundColor = UIColor.flatWhiteColor()
        self.careerDescriptionLabel.layer.masksToBounds = true
        self.careerDescriptionLabel.layer.cornerRadius = 10
        
        self.minEduReqsHeaderLabel.textAlignment = .Center
        self.minEduReqsHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.minEduReqsHeaderLabel.textColor = UIColor.flatBlueColorDark()
        self.minEduReqsHeaderLabel.userInteractionEnabled = true
        
        let gestureRecognizerMinEdu = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.showMinEduReqsAlert))
        self.minEduReqsHeaderLabel.addGestureRecognizer(gestureRecognizerMinEdu)
        
        self.minEduReqsDescriptionLabel.textAlignment = .Center
        self.minEduReqsDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.minEduReqsDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.salaryHeaderLabel.textAlignment = .Center
        self.salaryHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.salaryHeaderLabel.textColor = UIColor.flatBlueColorDark()
        self.salaryHeaderLabel.userInteractionEnabled = true
        
        let gestureRecognizerSalary = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.showSalaryAlert))
        self.salaryHeaderLabel.addGestureRecognizer(gestureRecognizerSalary)
        
        self.salaryDescriptionLabel.textAlignment = .Center
        self.salaryDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.salaryDescriptionLabel.textColor = UIColor.flatTealColor().lightenByPercentage(0.2)
        
        self.locationQuotientLabel.textAlignment = .Center
        self.locationQuotientLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.locationQuotientLabel.textColor = UIColor.flatBlueColorDark()
        self.locationQuotientLabel.userInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.locationQuotientButtonAlert))
        self.locationQuotientLabel.addGestureRecognizer(gestureRecognizer)
        
        self.howToBecomeOneView.backgroundColor = UIColor.flatPlumColor()
        
        self.howToBecomeOneLabel.textAlignment = .Center
        self.howToBecomeOneLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.howToBecomeOneLabel.textColor = UIColor.flatWhiteColor()
        
        self.howToBecomeOneDescription.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.howToBecomeOneDescription.textColor = UIColor.flatWhiteColor()
        self.howToBecomeOneDescription.backgroundColor = UIColor.flatPlumColor()
        
        
    }
    
    func setTextForUILabels() {
        
        let jobDictionary = JSONParser().sortingOccupationBySOCCode((self.job?.dashSOCcode)!)
        
        if let jobOccupation = job?.occupation {
            self.careerHeaderLabel.text = jobOccupation.uppercaseString
        }
        //self.careerDescriptionLabel.text = "Aerospace engineering and operations technicians operate and maintain equipment used in developing, testing, and producing new aircraft and spacecraft. Increasingly, these workers are using computer-based modeling and simulation tools and processes in their work."
        
        self.careerDescriptionLabel.text = jobDictionary[JSONParser.occupationDescription]?.stringValue
        
        
        
        self.minEduReqsHeaderLabel.text = "Typical Entry-Level Education  ▸"
        self.locationQuotientLabel.text = "Location Quotient  ▸"
        
        //self.minEduReqsDescriptionLabel.text = "Associate's degree"
        
        
        
        self.minEduReqsDescriptionLabel.text = jobDictionary[JSONParser.occupationEdu]?.stringValue
        
        print("Job SOC Code:\(self.job?.dashSOCcode)")
        print("jobDictionary[JSONParser.occupationEdu]?.stringValue:\(jobDictionary[JSONParser.occupationEdu]?.stringValue)")
        
        self.salaryHeaderLabel.text = "Median Pay  ▸"
        
        if let jobSalary = job?.annualMeanSalary {
           self.salaryDescriptionLabel.text = "$\(jobSalary)"
        }
        
        self.howToBecomeOneLabel.text = "How to Become One".uppercaseString
        
        self.howToBecomeOneDescription.text = jobDictionary[JSONParser.occupationBecomeOne]?.stringValue
        
        //self.howToBecomeOneDescription.text = "Although employers prefer to hire applicants with a master’s degree or Ph.D., entry-level positions are available for those with a bachelor’s degree. Analysts typically have a degree in operations research, management science, analytics, math, engineering, computer science, or another technical or quantitative field."
    }
    
    @IBAction func showMinEduReqsAlert() {
        let alertController = UIAlertController(title: "Typical Entry-Level Education", message: "Typical level of education that most workers need to enter this occupation.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showSalaryAlert() {
        let alertController = UIAlertController(title: "Median Pay", message: "The wage at which half of the workers in the occupation earned more than that amount and half earned less. Median wage data are from the BLS Occupational Employment Statistics survey. In May 2015, the median annual wage for all workers was $36,200.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func locationQuotientButtonAlert() {
        let alertController = UIAlertController(title: "Location Quotient", message: "The location quotient is the ratio of the area concentration of occupational employment to the national average concentration. A location quotient greater than one indicates the occupation has a higher share of employment than average, and a location quotient less than one indicates the occupation is less prevalent in the area than average.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

}
