//
//  StatusCreationViewController.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps


class StatusCreationViewController: CTViewController {
    
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var numberPerson: UITextField!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.categoriesButton.contentEdgeInsets = UIEdgeInsetsMake(categoriesButton.contentEdgeInsets.top, 8, categoriesButton.contentEdgeInsets.bottom, 8)
        self.locationButton.contentEdgeInsets = UIEdgeInsetsMake(categoriesButton.contentEdgeInsets.top, 8, categoriesButton.contentEdgeInsets.bottom, 8)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addStatusAction(_ sender: AnyObject!) {
        
    }
    
    @IBAction func pickCategoriesAction(_ sender: AnyObject!) {
        
    }
    
    var placePicker: GMSPlacePicker?
    
    @IBAction func pickPlaceAction(_ sender: AnyObject!) {
        
        let center = CLLocationCoordinate2DMake(51.5108396, -0.0922251)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlace(callback: { (place, error) in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place attributions \(place.attributions)")
                self.locationButton.setTitle("\(place.name) - \(place.formattedAddress)", for: .normal)
            } else {
                print("No place selected")
            }
        })   
    }
}
