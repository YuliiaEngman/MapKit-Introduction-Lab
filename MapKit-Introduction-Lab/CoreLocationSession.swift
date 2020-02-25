//
//  CoreLocationSession.swift
//  MapKit-Introduction-Lab
//
//  Created by Yuliia Engman on 2/25/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation
import CoreLocation

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
        locationManager.startUpdatingLocation()
    }
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
        print("didEnterRegion")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion")
    }
}
