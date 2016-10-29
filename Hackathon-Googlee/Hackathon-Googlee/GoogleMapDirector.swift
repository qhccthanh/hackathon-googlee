//
//  GoogleMapDirector.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import GoogleMaps
import Google
import UIKit

class GoogleMapDirector: NSObject {
    
    var currentRoute: Route = Route.init()
    
    func showDirection(originMarker: CTMarker, destinationMarker: CTMarker, mapView: GMSMapView) {
        
        let origin = originMarker.position
        let dest = destinationMarker.position
        gettingDirection(origin: origin, destination: dest) { (result) in
            DispatchQueue.main.async {
                mapView.clear()
                originMarker.map = mapView
                destinationMarker.map = mapView
                self.addPolyLineWithEncodedStringInMap(encodedString: result.points, mapView: mapView)
            }
            
        }
    }

    
    static var lastGet: (origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D)?
    
    func gettingDirection( origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D,completion: @escaping (_ result: Route) -> Void ) {
        
        let service = "https://maps.googleapis.com/maps/api/directions/json"
        let originLat = origin.latitude
        let originLong = origin.longitude
        let destLat = destination.latitude
        let destLong = destination.longitude
        let language = "vi"
        let urlString = "\(service)?origin=\(originLat),\(originLong)&destination=\(destLat),\(destLong)&mode=driving&units=metric&sensor=true&language=\(language)&alternatives=true&key=AIzaSyCG7kHZYcxW5O3tjk-CNbsafSkeh8LEfL0"
        
        let directionsURL = URL(string: urlString)
        print(directionsURL)
        let task = URLSession.shared.dataTask(with: directionsURL!) { (data, response, err) in
            if err == nil {
                if let result = data {
                    
                    let dictionary = try! JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                    
                    
                    if let routes = dictionary["routes"] as? [NSDictionary] {
                        
                        var temp = Route()
                        for route in routes {
                            
                            if let legs = route["legs"] as? NSArray {
                                if let leg = legs.firstObject as? NSDictionary {
                                    temp = Route(leg: leg)
                                    print(temp.distance)
                                }
                            }
                            if let route = route["overview_polyline"] as? NSDictionary {
                                if let points = route["points"] as? String {
                                    temp.points = points
                                }
                            }
                            if let summary = route["summary"] as? String {
                                temp.summary = summary
                            }
                            
                            break
                        }
                        completion(temp)
                    }
                }
            }
        }
        task.resume()
    }
    
    func addPolyLineWithEncodedStringInMap(encodedString: String, mapView: GMSMapView) {
        let path = GMSPath(fromEncodedPath: encodedString)
        let polyLine = GMSPolyline(path: path)
        polyLine.path = path
        polyLine.strokeWidth = 3
        polyLine.strokeColor = UIColor.blue
        polyLine.map = mapView
    }
    

    
}

class Route: NSObject {
    
    var distance = ""
    var duration = ""
    var start_address = ""
    var end_address = ""
    var summary = ""
    var steps = [StepGo]()
    var points = ""
    var status = 0
    
    override init() {
        
    }
    
    func toDictionary() -> NSDictionary {
        var dicSteps = [NSDictionary]()
        for step in steps {
            dicSteps.append(step.toDictionary())
        }
        let value = [
            "distance": distance,
            "duration": duration,
            "start_address": start_address,
            "end_address": end_address,
            "summary": summary,
            "points": points,
            "status": status,
            "steps": dicSteps
        ] as [String : Any]
        return value as NSDictionary
    }
    
    init(leg: NSDictionary) {
        if let distance = leg["distance"] as? NSDictionary, let text = distance["text"] as? String {
            self.distance = text
        }
        if let duration = leg["duration"] as? NSDictionary, let text = duration["text"] as? String {
            self.duration = text
        }
        if let startAddress = leg["start_address"] as? String, let endAddress = leg["end_address"] as? String {
            self.start_address = startAddress
            self.end_address = endAddress
        }
        
        if let steps = leg["steps"] as? NSArray {
            for step in steps {
                if let step = step as? NSDictionary {
                    self.steps.append(StepGo(dic: step))
                }
            }
        }
        if let points = leg["points"] as? String {
            self.points = points
        }
        if let status = leg["status"] as? Int {
            self.status = status
        }
    }
}
class StepGo: NSObject {
    var distance = ""
    var duration = ""
    var instructions = ""
    var path = ""
    var end_Location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var start_Location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func toDictionary() -> NSDictionary {
        let value = [
            "distance": distance,
            "duration": duration,
            "polyline": [
                "points" : path
            ],
            "html_instructions": instructions,
            "end_location": [
                "lat": end_Location.latitude,
                "lng": end_Location.longitude
            ],
            "start_location": [
                "lat": start_Location.latitude,
                "lng": start_Location.longitude
            ]
        ] as [String : Any]
        
        return value as NSDictionary
    }
    
    init(dic: NSDictionary) {
        if let distance = dic["distance"] as? NSDictionary, let text = distance["text"] as? String {
            self.distance = text
        }
        if let duration = dic["duration"] as? NSDictionary, let text = duration["text"] as? String {
            self.duration = text
        }
        if let html_instructions = dic["html_instructions"] as? String {
            let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.caseInsensitive])
            
            let range = NSMakeRange(0, html_instructions.characters.count)
            let htmlLessString :String = regex.stringByReplacingMatches(in: html_instructions, options: [],
                                                                                range:range ,
                                                                                withTemplate: " ")
            self.instructions = htmlLessString.replacingOccurrences(of: "&nbsp", with: " ")
        }
        if let polyline = dic["polyline"] as? NSDictionary, let points = polyline["points"] as? String {
            path = points
        }
        if let end_location = dic["end_location"] as? NSDictionary {
            if let lat = end_location["lat"] as? Double, let long = end_location["lng"] as? Double {
                self.end_Location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            }
        }
        if let start_location = dic["start_location"] as? NSDictionary {
            if let lat = start_location["lat"] as? Double, let long = start_location["lng"] as? Double {
                self.start_Location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            }
        }
    }
}
