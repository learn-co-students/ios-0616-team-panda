
//  JobDetailViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.

import UIKit
import ChameleonFramework
import SnapKit
import SwiftFontName
//import USStatesColorMap
import CoreText
import Font_Awesome_Swift
import SwiftSpinner
import SwiftyJSON
import FirebaseAuth

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
//    var usaColorMapView: USStatesColorMap!
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
        
//        self.usaColorMapView.backgroundColor = UIColor.clear
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTextForUILabels()
        self.setupNavBar()
        if let job = self.job {
            
            if job.locationQuotient.isEmpty {
                
                self.activityIndicator.startAnimating()
                
                store.getLocationQuotientforSOCCodeWithCompletion(job.SOCcode) { (lqDictionaryByState, error) in
                    
                    if let lqDictionaryByState = lqDictionaryByState {
                        
//                        self.setLocationQuotientMap(lqDictionaryByState)
                        job.locationQuotient = lqDictionaryByState
                        print("Completed.")
                        self.lqMapWarningLabel.isHidden = true

                    }
                    self.activityIndicator.stopAnimating()
                }
            }
            else {
//                self.setLocationQuotientMap(job.locationQuotient)
            }
        }
        SwiftSpinner.hide()
    }
    
    func setupNavBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: faveStar, style: .plain, target: self, action: #selector(saveToFavorites))
        
        if favoritedJob().0 == true {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.flatYellow()
        }
        else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue()
        }
    }
    
    func saveToFavorites() {
        
        if store.tpUser!.uid == Secrets.genericUserUID {
            let alert = Constants.displayAlertWith("Oops!", message: "Saving jobs to favorites is only for logged in users. Go to Settings > Log Out and sign up to unlock full access to CareerSpark. It's free!", actionLabel: "Got it!", style: .default, actionHandler: { })
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let favoriteInfo = favoritedJob()
            
            if favoriteInfo.0 == true {
                
                print("Already saved! Removing from favorites")
                navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue()
                store.tpUser!.favoritesArray.remove(at: favoriteInfo.1!)
                
                
            } else {
                print("Saving to favorites!")
                store.tpUser!.favoritesArray.append((self.job?.SOCcode)!)
                navigationItem.rightBarButtonItem?.tintColor = UIColor.flatYellow()
            }
            
            store.tpUser!.updateDatabase()
        }
    }
    
    func favoritedJob() -> (Bool, Int?) {
        
        if store.tpUser!.favoritesArray.contains((self.job?.SOCcode)!) {
            
            let index = store.tpUser!.favoritesArray.index(of: self.job!.SOCcode)
            return (true, index)
        }
        else {
            return (false, nil)
        }
    }
    
    func createViews() {
        
        scrollView = UIScrollView(frame: view.bounds)
        self.scrollView.delegate = self
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        
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
        
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
//        self.usaColorMapView = USStatesColorMap(frame: CGRect(x: 0, y: 0, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.width - 20))
//        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: self.usaColorMapView.frame.width, height: self.usaColorMapView.frame.height)
        
//        scrollView.addSubview(self.usaColorMapView)
//        self.usaColorMapView.addSubview(self.activityIndicator)
        self.scrollView.bringSubview(toFront: locationQuotientLabel)
        
        self.careerHeaderLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.scrollView)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.2)
        }
        
        self.careerHeaderLabel.sizeToFit()
        self.careerHeaderLabel.adjustsFontSizeToFitWidth = true
        
        self.careerDescriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.careerHeaderLabel.snp.bottom).offset(self.careerHeaderLabel.frame.height * 6)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.careerDescriptionLabel.isEditable = false
        self.careerDescriptionLabel.isSelectable = false
        self.careerDescriptionLabel.sizeToFit()
        self.careerDescriptionLabel.isScrollEnabled = false
        
        self.minEduReqsHeaderLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.careerDescriptionLabel.snp.bottom).offset(30)
        }
        
        self.minEduReqsDescriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.minEduReqsHeaderLabel.snp.bottom).offset(10)
        }
        
        self.salaryHeaderLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.minEduReqsDescriptionLabel.snp.bottom).offset(20)
        }
        
        self.salaryDescriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.salaryHeaderLabel.snp.bottom).offset(10)
        }
        
        self.locationQuotientLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.top.equalTo(self.salaryDescriptionLabel.snp.bottom).offset(20)
        }
        
//        self.usaColorMapView.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view)
//            make.top.equalTo(self.locationQuotientLabel.snp.bottom).offset(-70)
//            make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
//            make.height.equalTo(self.view.snp.width)
//        }
        
        self.lqMapWarningLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
//            make.top.equalTo(self.usaColorMapView.snp.bottom).offset(-40)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.locationQuotientLabel)
        }
        
        self.howToBecomeOneDescription.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.howToBecomeOneLabel.snp.bottomMargin).offset(10)
            make.bottom.equalTo(self.scrollView.snp.bottom)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.howToBecomeOneView.snp.makeConstraints { (make) in
//            make.top.equalTo(usaColorMapView.snp_bottomMargin).offset(10)
            make.width.equalTo(self.view.snp.width)
            make.bottom.equalTo(self.scrollView.snp.bottom)
        }
        
        self.howToBecomeOneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.howToBecomeOneView.snp.topMargin).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.9)
        }
        
        self.howToBecomeOneDescription.isEditable = false
        self.howToBecomeOneDescription.isSelectable = false
        self.howToBecomeOneDescription.isScrollEnabled = false
        
        scrollView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.topLayoutGuide)
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
//            make.bottom.equalTo(self.bottomLayoutGuide)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        howToBecomeOneDescription.sizeToFit()
    }
    
//    func setLocationQuotientMap(_ dictionary: [String : Double]) {
//        
//        
//        //        self.usaColorMapView.backgroundColor = UIColor.clearColor()
//        //        self.usaColorMapView.setColorForAllStates(UIColor.flatGrayColor())
//        
//        
//        self.usaColorMapView.performUpdates {
//            
//            self.usaColorMapView.setColor(UIColor.flatRedColorDark(), forState: DistrictOfColumbia)
//            
//            for (state, locationQuotient) in dictionary {
//                
//                switch locationQuotient {
//                    
//                case 0..<0.40 :
//                    self.usaColorMapView.setColor(UIColor.flatWatermelonColorDark(), forStateByName: state)
//                    
//                case 0.4..<0.8 :
//                    self.usaColorMapView.setColor(UIColor.flatRed(), forStateByName: state)
//                    
//                case 0.8..<1.25 :
//                    self.usaColorMapView.setColor(UIColor.flatRedColorDark(), forStateByName: state)
//                    
//                case 1.25..<2.50 :
//                    self.usaColorMapView.setColor(UIColor.flatMaroon(), forStateByName: state)
//                    
//                case 2.50..<10.0 :
//                    self.usaColorMapView.setColor(UIColor.flatBrown(), forStateByName: state)
//                    
//                default:
//                    self.usaColorMapView.setColor(UIColor.flatGray(), forStateByName: state)
//                    print("No location quotient for \(state)")
//                }
//            }
//        }
//    }
    
    func setStylingForViews() {
        
        scrollView.backgroundColor = UIColor.flatWhite()
        
        self.careerHeaderLabel.backgroundColor = UIColor.flatMintColorDark()
        self.careerHeaderLabel.textAlignment = .center
        self.careerHeaderLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.careerHeaderLabel.textColor = UIColor.flatWhite()
        self.careerHeaderLabel.layer.masksToBounds = true
        
        self.careerDescriptionLabel.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.careerDescriptionLabel.textColor = UIColor.flatMintColorDark()
        self.careerDescriptionLabel.backgroundColor = UIColor.flatWhite()
        self.careerDescriptionLabel.layer.masksToBounds = true
        self.careerDescriptionLabel.layer.cornerRadius = 10
        
        self.minEduReqsHeaderLabel.textAlignment = .center
        self.minEduReqsHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.minEduReqsHeaderLabel.textColor = UIColor.flatBlueColorDark()
        self.minEduReqsHeaderLabel.isUserInteractionEnabled = true
        
        let gestureRecognizerMinEdu = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.showMinEduReqsAlert))
        self.minEduReqsHeaderLabel.addGestureRecognizer(gestureRecognizerMinEdu)
        
        self.minEduReqsDescriptionLabel.textAlignment = .center
        self.minEduReqsDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.minEduReqsDescriptionLabel.textColor = UIColor.flatTeal().lighten(byPercentage: 0.2)
        self.minEduReqsDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        self.salaryHeaderLabel.textAlignment = .center
        self.salaryHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.salaryHeaderLabel.textColor = UIColor.flatBlueColorDark()
        self.salaryHeaderLabel.isUserInteractionEnabled = true
        
        let gestureRecognizerSalary = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.showSalaryAlert))
        self.salaryHeaderLabel.addGestureRecognizer(gestureRecognizerSalary)
        
        self.salaryDescriptionLabel.textAlignment = .center
        self.salaryDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.salaryDescriptionLabel.textColor = UIColor.flatTeal().lighten(byPercentage: 0.2)
        
        self.locationQuotientLabel.textAlignment = .center
        self.locationQuotientLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.locationQuotientLabel.textColor = UIColor.flatBlueColorDark()
        self.locationQuotientLabel.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.locationQuotientButtonAlert))
        self.locationQuotientLabel.addGestureRecognizer(gestureRecognizer)
        
        self.lqMapWarningLabel.font = UIFont.pandaFontLight(withSize: 14)
        self.lqMapWarningLabel.text = "*Location Quotient data isn't available for all occupations."
        self.lqMapWarningLabel.textAlignment = NSTextAlignment.center
        self.lqMapWarningLabel.isHidden = false
        
        self.howToBecomeOneView.backgroundColor = UIColor.flatPlum()
        
        self.howToBecomeOneLabel.textAlignment = .center
        self.howToBecomeOneLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.howToBecomeOneLabel.textColor = UIColor.flatWhite()
        
        self.howToBecomeOneDescription.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.howToBecomeOneDescription.textColor = UIColor.flatWhite()
        self.howToBecomeOneDescription.backgroundColor = UIColor.flatPlum()
        
        self.lqMapWarningLabel.font = UIFont.pandaFontLight(withSize: 14)
        self.lqMapWarningLabel.text = "*Location Quotient data isn't available for all occupations."
        self.lqMapWarningLabel.textAlignment = NSTextAlignment.center
        self.lqMapWarningLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setTextForUILabels() {
        if self.hasParsedJSON == false {
            jobDictionary = JSONParser().sortingOccupationBySOCCode((self.job?.dashSOCcode)!)
            self.hasParsedJSON = true
        }
        
        if let jobOccupation = job?.occupation {
            self.careerHeaderLabel.text = jobOccupation.uppercased()
        }
        
        self.minEduReqsHeaderLabel.text = "Typical Entry-Level Education  ▸"
        self.locationQuotientLabel.text = "Location Quotient  ▸"
        self.salaryHeaderLabel.text = "Median Pay  ▸"
        self.howToBecomeOneLabel.text = "How to Become One".uppercased()
        
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
    
    func addCommaToSalary(_ SalaryString: String) -> String {
        
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.numberStyle = NumberFormatter.Style.decimal
        let number: NSNumber = numberFormatter1.number(from: SalaryString)!
        
        let unitedStatesLocale = Locale(identifier: "en_US")
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        numberFormatter.locale = unitedStatesLocale
        
        return numberFormatter.string(from: number)!
        
    }
    
    @IBAction func showMinEduReqsAlert() {
        let alertController = UIAlertController(title: "Typical Entry-Level Education", message: "Typical level of education that most workers need to enter this occupation.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showSalaryAlert() {
        let alertController = UIAlertController(title: "Median Pay", message: "The wage at which half of the workers in the occupation earned more than that amount and half earned less. Median wage data are from the BLS Occupational Employment Statistics survey. In May 2015, the median annual wage for all workers was $36,200.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func locationQuotientButtonAlert() {
        let alertController = UIAlertController(title: "Location Quotient", message: "The location quotient is the ratio of the area concentration of occupational employment to the national average concentration. A location quotient greater than one indicates the occupation has a higher share of employment than average, and a location quotient less than one indicates the occupation is less prevalent in the area than average.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
