
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
import SwiftSpinner
import SwiftyJSON

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
    var activityIndicator: UIActivityIndicatorView!
    var lqMapWarningLabel = UILabel()
    
    var tempArray = [String]()
    
    var jobDictionary : [String : JSON] = [:]
    var hasParsedJSON : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setStylingForViews()
        
        self.usaColorMapView.backgroundColor = UIColor.clearColor()
        
        self.setupNavBar()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        setTextForUILabels()
        
        if let job = self.job {
            
            if job.locationQuotient.isEmpty {
                
                self.activityIndicator.startAnimating()
                
                store.getLocationQuotientforSOCCodeWithCompletion(job.SOCcode) { (lqDictionaryByState, error) in
                    
                    if let lqDictionaryByState = lqDictionaryByState {
                        
                        self.setLocationQuotientMap(lqDictionaryByState)
                        job.locationQuotient = lqDictionaryByState
                        print("Completed.")
                        self.activityIndicator.stopAnimating()
                        
                    } else if let error = error {
                        
                        let alert =  Constants.displayAlertWith("Network Error", message: error.localizedDescription, actionLabel: "Try Again", style: UIAlertActionStyle.Cancel, actionHandler: {})
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    self.lqMapWarningLabel.hidden = true
                    // print(lqDictionaryByState)
                }
                
            }
            else {
                self.setLocationQuotientMap(job.locationQuotient)
            }
        }
        SwiftSpinner.hide()
    }
    
    func setupNavBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: faveStar, style: .Plain, target: self, action: #selector(saveToFavorites))
        
        if favoritedJob().0 == true {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.flatYellowColor()
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
            navigationItem.rightBarButtonItem?.tintColor = UIColor.flatYellowColor()
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
        scrollView.addSubview(self.lqMapWarningLabel)
        
        self.howToBecomeOneView.addSubview(howToBecomeOneLabel)
        self.howToBecomeOneView.addSubview(howToBecomeOneDescription)
        
        self.view.addSubview(scrollView)
        
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        self.usaColorMapView = USStatesColorMap(frame: CGRectMake(0, 0, self.scrollView.frame.width - 20, self.scrollView.frame.width - 20))
        self.activityIndicator.frame = CGRectMake(0, 0, self.usaColorMapView.frame.width, self.usaColorMapView.frame.height)
        
        scrollView.addSubview(self.usaColorMapView)
        self.usaColorMapView.addSubview(self.activityIndicator)
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
        
        self.lqMapWarningLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.usaColorMapView.snp_bottom).offset(-40)
            make.width.equalTo(self.view.snp_width).multipliedBy(0.9)
            make.height.equalTo(self.locationQuotientLabel)
        }
        
        
        self.howToBecomeOneDescription.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.howToBecomeOneLabel.snp_bottomMargin).offset(10)
            make.bottom.equalTo(self.scrollView.snp_bottom)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.howToBecomeOneView.snp_makeConstraints { (make) in
            make.top.equalTo(usaColorMapView.snp_bottomMargin).offset(10)
            make.width.equalTo(self.view.snp_width)
            make.bottom.equalTo(self.scrollView.snp_bottom)
        }
        
        self.howToBecomeOneLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.howToBecomeOneView.snp_topMargin).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.howToBecomeOneDescription.editable = false
        self.howToBecomeOneDescription.selectable = false
        self.howToBecomeOneDescription.scrollEnabled = false
        
        scrollView.snp_makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide)
        }
        
        howToBecomeOneDescription.sizeToFit()
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
        
        self.lqMapWarningLabel.font = UIFont.pandaFontLight(withSize: 14)
        self.lqMapWarningLabel.text = "*Location Quotient data isn't available for all occupations."
        self.lqMapWarningLabel.textAlignment = NSTextAlignment.Center
        self.lqMapWarningLabel.hidden = false
        
        self.howToBecomeOneView.backgroundColor = UIColor.flatPlumColor()
        
        self.howToBecomeOneLabel.textAlignment = .Center
        self.howToBecomeOneLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.howToBecomeOneLabel.textColor = UIColor.flatWhiteColor()
        
        self.howToBecomeOneDescription.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.howToBecomeOneDescription.textColor = UIColor.flatWhiteColor()
        self.howToBecomeOneDescription.backgroundColor = UIColor.flatPlumColor()
        
    }
    
    func setTextForUILabels() {
        if self.hasParsedJSON == false {
            jobDictionary = JSONParser().sortingOccupationBySOCCode((self.job?.dashSOCcode)!)
            self.hasParsedJSON = true
        }
        
        if let jobOccupation = job?.occupation {
            self.careerHeaderLabel.text = jobOccupation.uppercaseString
        }
        
        self.minEduReqsHeaderLabel.text = "Typical Entry-Level Education  ▸"
        self.locationQuotientLabel.text = "Location Quotient  ▸"
        self.salaryHeaderLabel.text = "Median Pay  ▸"
        self.howToBecomeOneLabel.text = "How to Become One".uppercaseString
        
        self.careerDescriptionLabel.text = jobDictionary[JSONParser.occupationDescription]?.stringValue
        
        if jobDictionary[JSONParser.occupationEdu]?.stringValue == "" {
            self.minEduReqsDescriptionLabel.text = "Varies"
        } else {
            self.minEduReqsDescriptionLabel.text = jobDictionary[JSONParser.occupationEdu]?.stringValue
        }
        
        if let jobSalary = job?.annualMeanSalary {
            self.salaryDescriptionLabel.text = "$\(addCommaToSalary(jobSalary))"
        }
        self.howToBecomeOneDescription.text = jobDictionary[JSONParser.occupationBecomeOne]?.stringValue
        
    }
    
    func addCommaToSalary(SalaryString: String) -> String {
        
        let numberFormatter1 = NSNumberFormatter()
        numberFormatter1.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let number: NSNumber = numberFormatter1.numberFromString(SalaryString)!
        
        let unitedStatesLocale = NSLocale(localeIdentifier: "en_US")
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        numberFormatter.locale = unitedStatesLocale
        
        return numberFormatter.stringFromNumber(number)!
        
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
