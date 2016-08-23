
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
import CoreText
import Font_Awesome_Swift

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
    
    var tempArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setStylingForViews()
        setTextForUILabels()
        
        self.usaColorMapView.backgroundColor = UIColor.clearColor()
        
        self.setupNavBar()
        
//        if let job = self.job {
//            
//            if job.locationQuotient.isEmpty {
//                
//                store.getLocationQuotientforSOCCodeWithCompletion(job.SOCcode) { (lqDictionaryByState) in
//                    self.setLocationQuotientMap(lqDictionaryByState)
//                    job.locationQuotient = lqDictionaryByState
//                    print(lqDictionaryByState)
//                    print("Completed.")
//                }
//            }
//            else {
//                self.setLocationQuotientMap(job.locationQuotient)
//            }
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let job = self.job {
            
            if job.locationQuotient.isEmpty {
                
                store.getLocationQuotientforSOCCodeWithCompletion(job.SOCcode) { (lqDictionaryByState) in
                    self.setLocationQuotientMap(lqDictionaryByState)
                    job.locationQuotient = lqDictionaryByState
                    print(lqDictionaryByState)
                    print("Completed.")
                }
            }
            else {
                self.setLocationQuotientMap(job.locationQuotient)
            }
        }
    }
    
    func setupNavBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: faveStar, style: .Plain, target: self, action: #selector(saveToFavorites))

        if favoritedJob().0 == true {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.yellowColor()
        }
        else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue()
        }
    }
    
    func saveToFavorites() {
        
        let favoriteInfo = favoritedJob()
        
        if favoriteInfo.0 == true {
            
            print("Already saved! Removing from favorites")
            navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue()
            store.tpUser!.favoritesArray.removeAtIndex(favoriteInfo.1!)
            
            
        } else {
            print("Saving to favorites!")
            store.tpUser!.favoritesArray.append((self.job?.SOCcode)!)
            navigationItem.rightBarButtonItem?.tintColor = UIColor.yellowColor()
        }
        
        store.tpUser!.updateDatabase()
    }
    
    func favoritedJob() -> (Bool, Int?) {
        
        if store.tpUser!.favoritesArray.contains((self.job?.SOCcode)!) {
            
            let index = store.tpUser!.favoritesArray.indexOf(self.job!.SOCcode)
            return (true, index)
        }
        else {
            return (false, nil)
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
        
//        self.usaColorMapView.backgroundColor = UIColor.clearColor()
//        self.usaColorMapView.setColorForAllStates(UIColor.flatGrayColor())
        self.usaColorMapView.performUpdates {
            
            self.usaColorMapView.setColor(UIColor.flatRedColorDark(), forState: DistrictOfColumbia)
            
            for (state, locationQuotient) in dictionary {

                switch locationQuotient {
                    
                case 0..<0.40 :
                    self.usaColorMapView.setColor(UIColor.flatWatermelonColorDark(), forStateByName: state)
                    
                case 0.4..<0.8 :
                    self.usaColorMapView.setColor(UIColor.flatRedColor(), forStateByName: state)
                    
                case 0.8..<1.25 :
                    self.usaColorMapView.setColor(UIColor.flatRedColorDark(), forStateByName: state)
                    
                case 1.25..<2.50 :
                    self.usaColorMapView.setColor(UIColor.flatMaroonColor(), forStateByName: state)
                    
                case 2.50..<10.0 :
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
        
        self.minEduReqsHeaderLabel.text = "Typical Entry-Level Education  ▸"
        self.locationQuotientLabel.text = "Location Quotient  ▸"
        self.salaryHeaderLabel.text = "Median Pay  ▸"
        self.howToBecomeOneLabel.text = "How to Become One".uppercaseString
        
        self.careerDescriptionLabel.text = jobDictionary[JSONParser.occupationDescription]?.stringValue
        self.minEduReqsDescriptionLabel.text = jobDictionary[JSONParser.occupationEdu]?.stringValue
        if let jobSalary = job?.annualMeanSalary {
           self.salaryDescriptionLabel.text = "$\(jobSalary)"
        }
        self.howToBecomeOneDescription.text = jobDictionary[JSONParser.occupationBecomeOne]?.stringValue

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
