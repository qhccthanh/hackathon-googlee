//
//  LocationManager.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import CoreLocation

//protocol LocationManagerDelegate: class {
//    
//    func locationManager(_ location: CLLocation)
//    
//    func locationManager(_ status: CLAuthorizationStatus)
//}

public class LocationManager: NSObject {
    
//    weak var delegate: LocationManagerDelegate?
    static let locationManager = LocationManager()
    private var manager: CLLocationManager!
    
    public var location: CLLocation!
    var completionBlock: ((_ location: CLLocation)->())?
    
    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self

    }
    
    public func requestPermission() {
        manager.requestAlwaysAuthorization()
    }
    
    public func getCurrentLocation(_ closure: @escaping (CLLocation)->()) {
        manager.requestLocation()
        completionBlock = closure
    }
    
    public func enableUpdateLocation() {
        manager.startUpdatingLocation()
    }
    
    public func disableUpdateLocation() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        completionBlock!(location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
