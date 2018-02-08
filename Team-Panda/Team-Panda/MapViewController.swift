//
//  MapViewController.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController, MKMapViewDelegate {

    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMapViews()
        self.view.addSubview(mapView)
        setInitialLocation()
    }
    
    private let regionRadius: CLLocationDistance = 100000
    
    private func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func setInitialLocation() {
        let initialLocation = CLLocation(latitude: 42.014988, longitude: -95.3602758)
        centerMapOnLocation(initialLocation)
    }
    
    private func createMapViews() {
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
    }
}
