//
//  MarkerManager.swift
//  Hackathon-Googlee
//
//  Created by Quach Ha Chan Thanh on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import GoogleMaps

class MarkerManager: NSObject {
    
    private var markerList = [CTMarker]()
    private var mapView: GMSMapView!
    
    override init(){
        super.init()
    }
    
    init(withMapView _mapView: GMSMapView) {
        super.init()
        
        mapView = _mapView
    }
    
    func addMarker(_ marker: CTMarker) {
        markerList.append(marker)
        marker.map = mapView
    }
    
    func removeMarkerWithIdentifier(_ identifier: String) {
        let arrayFilter = markerList.filter { (marker) -> Bool in
            if marker.identifier == identifier {
                return true
            }
            else {
                return false
            }
        }
        
        for marker in arrayFilter {
            marker.map = nil
            markerList.remove(at: markerList.index(of: marker)!)
        }
    }
}
