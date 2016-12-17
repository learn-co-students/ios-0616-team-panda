//
//  SignUpPageViewController.swift
//  Team-Panda
//
//  Created by Salmaan Rizvi on 8/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import ChameleonFramework

class SignUpPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var viewsArray : [UIViewController]!
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]?) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.accessibilityLabel = "Sign Up PVC"
        self.viewsArray = self.createInitialViewController()
        
        self.setViewControllers([viewsArray[0]], direction: .forward, animated: true) { (completed) in
            print(self.viewControllers?.first?.accessibilityLabel)
        }
        
    }
    
    // Transitions to next view controller based on the button that was tapped
    func nextViewController(_ style : WouldYouRatherStyle) {
        
        let nextVC = WouldYouRatherViewController(withUIStyle: style)
        
        self.setViewControllers([nextVC], direction: .forward, animated: true, completion: { (completed) in
            
            if style == .Make { print("Transitioned to Making View Controller") }
            else { print("Transitioned to Thinking View Controller") }
        })

    }
    
    func nextViewController(_ style : WhichInterestsStyle) {
        let nextVC = WhichInterestsYouViewController(withUIStyle: style)
        
        self.setViewControllers([nextVC], direction: .forward, animated: true) { (completed) in
            print("Third VC")
        }
    }
    
    override var prefersStatusBarHidden : Bool { return true }
    
    
    /*
     * PageViewController Implementation Methods
     */
    
    func createInitialViewController() -> [UIViewController] {
        
        let tellUsVC = TellUsAboutYourselfViewController()
        tellUsVC.accessibilityLabel = "Tell Us VC"
        
        return [tellUsVC]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = self.viewControllers?.first else { return nil }
        
        guard let index = self.viewsArray.index(of: currentVC) else { return nil }
        
        if index == 0 {
            return nil
        } else {
            return self.viewsArray[index - 1]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = self.viewControllers?.first else { return nil }
        
        guard let index = self.viewsArray.index(of: currentVC) else { return nil }
        
        if index == self.viewsArray.count - 1 {
            return nil
        } else {
            return self.viewsArray[index + 1]
        }
    }
}
