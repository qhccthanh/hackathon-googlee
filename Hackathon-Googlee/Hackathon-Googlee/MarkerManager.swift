//
//  MarkerManager.swift
//  Hackathon-Googlee
//
//  Created by Quach Ha Chan Thanh on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

class MarkerManager: NSObject {
    
    private var markerList: [CTMarker]!
    
    override init(){
        super.init()
    }
    
    func addMarker(_ marker: CTMarker) {
        markerList.append(marker)
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
            markerList.remove(at: markerList.index(of: marker)!)
        }
    }
}
