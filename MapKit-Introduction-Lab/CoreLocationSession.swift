//
//  CoreLocationSession.swift
//  MapKit-Introduction-Lab
//
//  Created by Yuliia Engman on 2/25/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation
import CoreLocation

//struct Location {
//    let title: String
//    let body: String
//    let coordinate: CLLocationCoordinate2D
//    let imageName: String
//
//    // this is Model -> In the lab I shpuld use JSON
//    static func getLocations() -> [Location] {
//        return [
//            Location(title: "Pursuit", body: "We train adults with the most need and potential to get hired in tech, advance in their careers, and become the next generation of leaders in tech.", coordinate: CLLocationCoordinate2D(latitude: 40.74296, longitude: -73.94411), imageName: "team-6-3"),
//            Location(title: "Brooklyn Museum", body: "The Brooklyn Museum is an art museum located in the New York City borough of Brooklyn. At 560,000 square feet (52,000 m2), the museum is New York City's third largest in physical size and holds an art collection with roughly 1.5 million works", coordinate: CLLocationCoordinate2D(latitude: 40.6712062, longitude: -73.9658193), imageName: "brooklyn-museum"),
//            Location(title: "Central Park", body: "Central Park is an urban park in Manhattan, New York City, located between the Upper West Side and the Upper East Side. It is the fifth-largest park in New York City by area, covering 843 acres (3.41 km2). Central Park is the most visited urban park in the United States, with an estimated 37.5–38 million visitors annually, as well as one of the most filmed locations in the world.", coordinate: CLLocationCoordinate2D(latitude: 40.7828647, longitude: -73.9675438), imageName: "central-park")
//        ]
//    }
//}

class CoreLocationSession: NSObject {
    
    public var locationManager: CLLocationManager //dont need ! since we setting locationManager with a value (locationManager = CLLocationManager())
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        
        //withput delegate will will not get updates
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        /*
         MapKit-Introduction-Lab[23985:2370638] This app has attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain both “NSLocationAlwaysAndWhenInUseUsageDescription” and “NSLocationWhenInUseUsageDescription” keys with string values explaining to the user how the app uses this data
         
         WE NEED TO ADD THOSE 2 KEYS (“NSLocationAlwaysAndWhenInUseUsageDescription” and “NSLocationWhenInUseUsageDescription”) to PLIST
         We need to give value (description))
         */
        
        //get updates for user location
        
        // is more aggressive solution for GPS data collection
        //locationManager.startUpdatingLocation()
        
        // less aggressive on battery consumption and GPS data collection
        startSignificantLocationChanges()
        
       // startMonitoringRegion()
    }
    
    private func startSignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            //not available on device
            return
        }
        //less aggressive than locationManager.startUpdatingLocation() in GPS monitor changes
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    // 2D has latitude and longitude (2 values)
    public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
        // we will use the CLGeocoder() class for converting coordinate (CLLocationCoordinate2D) to placemark (CLPlacemark)
        
        //we need to create CLLocation
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks,
            error) in
            if let error = error {
                print("reverseGeocodeLocation: \(error)")
            }
            if let firstPlacemark = placemarks?.first {
                print("placemark info: \(firstPlacemark)")
            }
        }
    }
    
    public func convertPlaceNameToCoordinate(addressString: String) {
        // converting an address to a coordinate
        CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("geocodeAddressString: \(error)")
            }
            if let firstPlacemark = placemarks?.first,
                let location = firstPlacemark.location {
                print("place name coordinate is \(location.coordinate)")
            }
        }
    }
    
    //monitor a CLRegion - is made up of centered coordinate and radius in meters
//    private func startMonitoringRegion() {
//        let location = Location.getLocations()[2]
//        let identifier = "monitoring region"
//        let region = CLCircularRegion(center: location.coordinate, radius: 500, identifier: identifier)
//        region.notifyOnEntry = true
//        region.notifyOnExit = false
//        
//        locationManager.startMonitoring(for: region)
//    }
}

extension CoreLocationSession: CLLocationManagerDelegate {
    //this methos is called when user changes the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations: \(locations)") //gives us back an array of CLLocations (ususally we need the last one - most updated)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // gives us status
        switch status {
        case .authorizedAlways:
            print("authorizedAlways") //purpose is to see state of authorization
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
            
        //we need to add default case since apple may add another cases:
        default:
            break
        }
    }
    
    //think about is as a circle
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion: \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion: \(region)")
    }
}
