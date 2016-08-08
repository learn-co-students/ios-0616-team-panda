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
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: options)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.accessibilityLabel = "Sign Up PVC"
        self.viewsArray = self.createViewControllers()
        
        self.setViewControllers([viewsArray[0]], direction: .Forward, animated: true) { (completed) in
            print("completed. not sure what this does")
            print(self.viewControllers?.first?.accessibilityLabel)
        }
        
    }
    
    func createViewControllers() -> [UIViewController] {
        
        let tellUsVC = TellUsAboutYourselfViewController()
        tellUsVC.accessibilityLabel = "Tell Us VC"
        
        return [tellUsVC]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = self.viewControllers?.first else { return nil }
        
        guard let index = self.viewsArray.indexOf(currentVC) else { return nil }
        
        if index == 0 {
            return nil
        } else {
            return self.viewsArray[index - 1]
        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = self.viewControllers?.first else { return nil }
        
        guard let index = self.viewsArray.indexOf(currentVC) else { return nil }
        
        if index == self.viewsArray.count - 1 {
            return nil
        } else {
            return self.viewsArray[index + 1]
        }    }
    
}
