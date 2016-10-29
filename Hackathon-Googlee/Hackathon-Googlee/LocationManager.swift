//
//  LocationManager.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let locationManager = LocationManager()

    private var manager: CLLocationManager!
    

    public var location: CLLocation!
    var completionBlock: ((_ location: CLLocation)->())?
    
    override init() {
        manager = CLLocationManager()
        super.init()
        self.requestPermission()
        self.enableUpdateLocation()
        manager.delegate = self
    }
    
    public func requestPermission() {
        manager.requestAlwaysAuthorization()
    }
    
    func requestPermission {
        
    }
    
    func getCurrentLocation {
    }
    
    public func disableUpdateLocation() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        if let completion = completionBlock {
            completion(location)
        }
    func checkPermission {
        
    }
    
    func enableUpdateLocation {
        
    }
    
    func disableUpdateLocation {
    }
}
