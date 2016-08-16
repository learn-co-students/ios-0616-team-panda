//
//  TestController.swift
//  Team-Panda
//
//  Created by Flatiron School on 8/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import USStatesColorMap
import CoreText
import ChameleonFramework

class TestController: UIViewController {
    
    var usaColorMapView: USStatesColorMap!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        self.usaColorMapView = USStatesColorMap(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width))
        self.view.addSubview(self.usaColorMapView)
        self.usaColorMapView.setColorForAllStates(UIColor.redColor())
        self.usaColorMapView.backgroundColor = UIColor.whiteColor()
        
        self.usaColorMapView.performUpdates {
            self.usaColorMapView.setColor(UIColor.flatRedColor(), forState: Alabama)
            self.usaColorMapView.setColor(UIColor.flatBlueColor(), forState: Alaska)
            self.usaColorMapView.setColor(UIColor.flatGreenColor(), forState: California)
        }

        /*
        Arkansas,
        Arizona,
        California,
        Colorado,
        Connecticut,
        Delaware,
        Florida,
        Georgia,
        Hawaii,
        Idaho,
        Illinois,
        Indiana,
        Iowa,
        Kansas,
        Kentucky,
        Louisiana,
        Maine,
        Maryland,
        Massachusetts,
        Michigan,
        Minnesota,
        Mississippi,
        Missouri,
        Montana,
        Nebraska,
        Nevada,
        NewHampshire,
        NewJersey,
        NewMexico,
        NewYork,
        NorthCarolina,
        NorthDakota,
        Ohio,
        Oklahoma,
        Oregon,
        Pennsylvania,
        RhodeIsland,
        SouthCarolina,
        SouthDakota,
        Tennessee,
        Texas,
        Utah,
        Virginia,
        Vermont,
        Washington,
        WestVirginia,
        Wisconsin,
        Wyoming,
        DistrictOfColumbia
 */
        
    }
    
    
    
}