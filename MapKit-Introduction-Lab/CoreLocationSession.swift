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
        
        //withput delegate will will not get updates
        locationManager.delegate = self
    }
}

extension CoreLocationSession: CLLocationManagerDelegate {
    
}
