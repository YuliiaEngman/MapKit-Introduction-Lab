//
//  ViewController.swift
//  MapKit-Introduction-Lab
//
//  Created by Yuliia Engman on 2/25/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView! //it is scroll view
    
    private let locationSession = CoreLocationSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing converting coordinate to placemark
        convertCoordinateToPlacemark()
        
        //testing converting place name to coordinate
        convertPlaceNameToCoordinate()
        
        // configure map view
        // attempt to show the user's current location
        mapView.showsUserLocation = true
    }
    
    func makeAnnotations() {
        var annotations = [MKPointAnnotation]()
        for location in Location.getLocations() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            annotations.append(annotation)
        }
    }
    
    private func convertCoordinateToPlacemark() {
          let location = Location.getLocations()[2]
        //gives us Central Park: Central Park, Central Park, West Dr, New York, NY  10028, United States
              locationSession.convertCoordinateToPlacemark(coordinate: location.coordinate)
      }
    
//    private func convertCoordinateToPlacemark() {
//        if let location = Location.getLocations().first {
//            locationSession.convertCoordinateToPlacemark(coordinate: location.coordinate)
//        }
//    }
    //Getting Pursuit location: placemark info: Skillman Ave, Skillman Ave, Long Island City, NY  11101, United States
    
    private func convertPlaceNameToCoordinate() {
        locationSession.convertPlaceNameToCoordinate(addressString: "Brooklyn Museum")
    }

}
