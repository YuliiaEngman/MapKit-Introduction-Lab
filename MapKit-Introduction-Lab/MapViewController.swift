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
        mapView.delegate = self
        
        loadMapView()
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in Location.getLocations() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            annotations.append(annotation)
        }
        return annotations
    }
    
    private func loadMapView() {
        let annotations = makeAnnotations()
        //we can add 1 annotation or many annotations (using bult-in func)ann
        mapView.addAnnotations(annotations)
        
        mapView.showAnnotations(annotations, animated: true)
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "locationAnnotation"
        var annotationView: MKPinAnnotationView
        
        // try to dequeue and reuse annotation view
        // if it excist just assign to our annotation
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
        annotationView = dequeueView
    } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
    }
    return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //bubble around annotation
        print("calloutAccessoryControlTapped ")
    }
}
