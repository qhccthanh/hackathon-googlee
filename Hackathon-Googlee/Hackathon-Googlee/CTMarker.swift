//
//  CTMarker.swift
//  Hackathon-Googlee
//
//  Created by Quach Ha Chan Thanh on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import GoogleMaps

class CTMarker : GMSMarker {
    
    public var identifier: String!
    
    override init(){
        super.init()
        
        identifier = ""
    }
}

class CTMarkerCreation : NSObject {
    
    public func markerWithIdentifier(_ identifier: String!, position: CLLocation, title: String?, image: UIImage?) -> CTMarker {
        
        let marker = CTMarker()
        marker.identifier = identifier
        marker.position = position.coordinate
        marker.title = title
        marker.icon = image
        
        return marker
    }
}
