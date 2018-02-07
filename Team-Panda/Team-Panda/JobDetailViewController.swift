
//  JobDetailViewController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.

import UIKit
import ChameleonFramework
import SwiftFontName
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

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTextForUILabels()
        self.setupNavBar()
        if let job = self.job {
            
            if job.locationQuotient.isEmpty {
                
                self.activityIndicator.startAnimating()
                
                store.getLocationQuotientforSOCCodeWithCompletion(job.SOCcode) { (lqDictionaryByState, error) in
                    
                    if let lqDictionaryByState = lqDictionaryByState {
                        
                        self.setLocationQuotientMap(lqDictionaryByState)
                        job.locationQuotient = lqDictionaryByState
                        print("Completed.")
                        self.lqMapWarningLabel.isHidden = true
                        
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
            else {
                self.setLocationQuotientMap(job.locationQuotient)
            }
        }
        SwiftSpinner.hide()
    }
    
    func setupNavBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: faveStar, style: .plain, target: self, action: #selector(saveToFavorites))
        
        if favoritedJob().0 == true {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.flatYellow
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
                navigationItem.rightBarButtonItem?.tintColor = UIColor.flatYellow
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
        scrollView.delegate = self
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        
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
        scrollView.addSubview(lqMapWarningLabel)
        
        howToBecomeOneView.addSubview(howToBecomeOneLabel)
        howToBecomeOneView.addSubview(howToBecomeOneDescription)
        
        view.addSubview(scrollView)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        usaColorMapView = USStatesColorMap(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width - 20, height: scrollView.frame.width - 20))
        activityIndicator.frame = CGRect(x: 0, y: 0, width: usaColorMapView.frame.width, height: usaColorMapView.frame.height)
        
        scrollView.addSubview(usaColorMapView)
        usaColorMapView.addSubview(activityIndicator)
        scrollView.bringSubview(toFront: locationQuotientLabel)
        
        careerHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        careerHeaderLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        careerHeaderLabel.safeTopAnchor.constraint(equalTo: scrollView.safeTopAnchor).isActive = true
        careerHeaderLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor).isActive = true
        careerHeaderLabel.safeHeightAnchor.constraint(equalTo: view.safeHeightAnchor, multiplier: 0.2).isActive = true
        
        careerHeaderLabel.sizeToFit()
        careerHeaderLabel.adjustsFontSizeToFitWidth = true
        
        careerDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        careerDescriptionLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        careerDescriptionLabel.safeTopAnchor.constraint(equalTo: careerHeaderLabel.safeBottomAnchor, constant: careerHeaderLabel.frame.height * 6).isActive = true
        careerDescriptionLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        
        careerDescriptionLabel.isEditable = false
        careerDescriptionLabel.isSelectable = false
        careerDescriptionLabel.sizeToFit()
        careerDescriptionLabel.isScrollEnabled = false
        
        minEduReqsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        minEduReqsHeaderLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        minEduReqsHeaderLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        minEduReqsHeaderLabel.safeTopAnchor.constraint(equalTo: careerDescriptionLabel.safeBottomAnchor, constant: 30).isActive = true
        
        minEduReqsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        minEduReqsDescriptionLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        minEduReqsDescriptionLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        minEduReqsDescriptionLabel.safeTopAnchor.constraint(equalTo: minEduReqsHeaderLabel.safeBottomAnchor, constant: 10).isActive = true
        
        salaryHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryHeaderLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        salaryHeaderLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        salaryHeaderLabel.safeTopAnchor.constraint(equalTo: minEduReqsDescriptionLabel.safeBottomAnchor, constant: 20).isActive = true
        
        salaryDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryDescriptionLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        salaryDescriptionLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        salaryDescriptionLabel.safeTopAnchor.constraint(equalTo: salaryHeaderLabel.safeBottomAnchor, constant: 10).isActive = true
        
        locationQuotientLabel.translatesAutoresizingMaskIntoConstraints = false
        locationQuotientLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        locationQuotientLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        locationQuotientLabel.safeTopAnchor.constraint(equalTo: salaryDescriptionLabel.safeBottomAnchor, constant: 20).isActive = true
        
        usaColorMapView.translatesAutoresizingMaskIntoConstraints = false
        usaColorMapView.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        usaColorMapView.safeTopAnchor.constraint(equalTo: locationQuotientLabel.safeBottomAnchor, constant: -70).isActive = true
        usaColorMapView.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        usaColorMapView.safeHeightAnchor.constraint(equalTo: view.safeWidthAnchor).isActive = true
        
        lqMapWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        lqMapWarningLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        lqMapWarningLabel.safeTopAnchor.constraint(equalTo: usaColorMapView.safeBottomAnchor, constant: -40).isActive = true
        lqMapWarningLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        lqMapWarningLabel.safeHeightAnchor.constraint(equalTo: locationQuotientLabel.safeHeightAnchor).isActive = true
        
        howToBecomeOneDescription.translatesAutoresizingMaskIntoConstraints = false
        howToBecomeOneDescription.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        howToBecomeOneDescription.safeTopAnchor.constraint(equalTo: howToBecomeOneLabel.safeBottomAnchor, constant: 10).isActive = true
        howToBecomeOneDescription.safeBottomAnchor.constraint(equalTo: scrollView.safeBottomAnchor).isActive = true
        howToBecomeOneDescription.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        
        howToBecomeOneView.translatesAutoresizingMaskIntoConstraints = false
        howToBecomeOneView.safeTopAnchor.constraint(equalTo: usaColorMapView.safeBottomAnchor, constant: 10).isActive = true
        howToBecomeOneView.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor).isActive = true
        howToBecomeOneView.safeBottomAnchor.constraint(equalTo: scrollView.safeBottomAnchor).isActive = true
        
        howToBecomeOneLabel.translatesAutoresizingMaskIntoConstraints = false
        howToBecomeOneLabel.safeTopAnchor.constraint(equalTo: howToBecomeOneView.safeTopAnchor, constant: 20).isActive = true
        howToBecomeOneLabel.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor).isActive = true
        howToBecomeOneLabel.safeWidthAnchor.constraint(equalTo: view.safeWidthAnchor, multiplier: 0.9).isActive = true
        
        howToBecomeOneDescription.isEditable = false
        howToBecomeOneDescription.isSelectable = false
        howToBecomeOneDescription.isScrollEnabled = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.safeTopAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.safeLeadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
        scrollView.safeTrailingAnchor.constraint(equalTo: view.safeTrailingAnchor).isActive = true
        scrollView.safeBottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        howToBecomeOneDescription.sizeToFit()
    }
    
    func setLocationQuotientMap(_ dictionary: [String : Double]) {
        
        self.usaColorMapView.setColorForAllStates(UIColor.flatGray)
        
        self.usaColorMapView.performUpdates {
            self.usaColorMapView.setColor(UIColor.flatRedDark, forState: DistrictOfColumbia)
            
            for (state, locationQuotient) in dictionary {
                
                switch locationQuotient {
                    
                case 0..<0.40 :
                    self.usaColorMapView.setColor(UIColor.flatWatermelonDark, forStateByName: state)
                    
                case 0.4..<0.8 :
                    self.usaColorMapView.setColor(UIColor.flatRed, forStateByName: state)
                    
                case 0.8..<1.25 :
                    self.usaColorMapView.setColor(UIColor.flatRedDark, forStateByName: state)
                    
                case 1.25..<2.50 :
                    self.usaColorMapView.setColor(UIColor.flatMaroon, forStateByName: state)
                    
                case 2.50..<10.0 :
                    self.usaColorMapView.setColor(UIColor.flatBrown, forStateByName: state)
                    
                default:
                    self.usaColorMapView.setColor(UIColor.flatGray, forStateByName: state)
                    print("No location quotient for \(state)")
                }
            }
        }
    }
    
    func setStylingForViews() {
        
        scrollView.backgroundColor = UIColor.flatWhite
        
        self.careerHeaderLabel.backgroundColor = UIColor.flatMintDark
        self.careerHeaderLabel.textAlignment = .center
        self.careerHeaderLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.careerHeaderLabel.textColor = UIColor.flatWhite
        self.careerHeaderLabel.layer.masksToBounds = true
        
        self.careerDescriptionLabel.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.careerDescriptionLabel.textColor = UIColor.flatMintDark
        self.careerDescriptionLabel.backgroundColor = UIColor.flatWhite
        self.careerDescriptionLabel.layer.masksToBounds = true
        self.careerDescriptionLabel.layer.cornerRadius = 10
        
        self.minEduReqsHeaderLabel.textAlignment = .center
        self.minEduReqsHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.minEduReqsHeaderLabel.textColor = UIColor.flatBlueDark
        self.minEduReqsHeaderLabel.isUserInteractionEnabled = true
        
        let gestureRecognizerMinEdu = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.showMinEduReqsAlert))
        self.minEduReqsHeaderLabel.addGestureRecognizer(gestureRecognizerMinEdu)
        
        self.minEduReqsDescriptionLabel.textAlignment = .center
        self.minEduReqsDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.minEduReqsDescriptionLabel.textColor = UIColor.flatTeal.lighten(byPercentage: 0.2)
        self.minEduReqsDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        self.salaryHeaderLabel.textAlignment = .center
        self.salaryHeaderLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.salaryHeaderLabel.textColor = UIColor.flatBlueDark
        self.salaryHeaderLabel.isUserInteractionEnabled = true
        
        let gestureRecognizerSalary = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.showSalaryAlert))
        self.salaryHeaderLabel.addGestureRecognizer(gestureRecognizerSalary)
        
        self.salaryDescriptionLabel.textAlignment = .center
        self.salaryDescriptionLabel.font = UIFont.pandaFontLight(withSize: 20)
        self.salaryDescriptionLabel.textColor = UIColor.flatTeal.lighten(byPercentage: 0.2)
        
        self.locationQuotientLabel.textAlignment = .center
        self.locationQuotientLabel.font = UIFont.pandaFontBold(withSize: 18)
        self.locationQuotientLabel.textColor = UIColor.flatBlueDark
        self.locationQuotientLabel.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JobDetailViewController.locationQuotientButtonAlert))
        self.locationQuotientLabel.addGestureRecognizer(gestureRecognizer)
        
        self.lqMapWarningLabel.font = UIFont.pandaFontLight(withSize: 14)
        self.lqMapWarningLabel.text = "*Location Quotient data isn't available for all occupations."
        self.lqMapWarningLabel.textAlignment = NSTextAlignment.center
        self.lqMapWarningLabel.isHidden = false
        
        self.howToBecomeOneView.backgroundColor = UIColor.flatPlum
        
        self.howToBecomeOneLabel.textAlignment = .center
        self.howToBecomeOneLabel.font = UIFont.pandaFontBold(withSize: 24.0)
        self.howToBecomeOneLabel.textColor = UIColor.flatWhite
        
        self.howToBecomeOneDescription.font = UIFont.pandaFontMedium(withSize: 18.0)
        self.howToBecomeOneDescription.textColor = UIColor.flatWhite
        self.howToBecomeOneDescription.backgroundColor = UIColor.flatPlum
        
        self.lqMapWarningLabel.font = UIFont.pandaFontLight(withSize: 14)
        self.lqMapWarningLabel.text = "*Location Quotient data isn't available for all occupations."
        self.lqMapWarningLabel.textAlignment = NSTextAlignment.center
        self.lqMapWarningLabel.adjustsFontSizeToFitWidth = true
        
        self.usaColorMapView.backgroundColor = UIColor.clear

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
