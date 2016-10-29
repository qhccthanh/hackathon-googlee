//
//  MainViewController.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MainViewController: CTViewController {
    
    @IBOutlet weak var tableView: UITableView?
    weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.isMyLocationEnabled = true
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
            let sydney = GMSCameraPosition.camera(withLatitude: mylocation.coordinate.latitude,
                                                              longitude: mylocation.coordinate.longitude, zoom: 6)
            mapView.camera = sydney
        } else {
            print("User's location is unknown")
            let target = CLLocationCoordinate2D(latitude: -33.868, longitude: 151.208)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 10)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        cell = (indexPath.section == 0 ? tableView.dequeueReusableCell(withIdentifier: "MapViewCell") : tableView.dequeueReusableCell(withIdentifier: "InfoCell"))!
        
        if indexPath.section == 0 {
            if let mapView = cell.contentView.subviews.first as? GMSMapView {
                self.mapView = mapView
            }
        } else {
            
            if let button = cell.contentView.viewWithTag(1) as? CBButton {
                button.id = indexPath.row
                button.addTarget(self, action: #selector(self.touchLocationCellAction), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    func touchLocationCellAction(_ sender: CBButton!) {
        let id = sender.id
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if let vc = Utility.getViewControllerWithClass(StatusDetailViewController.classForCoder()) {
            let popupController = STPopupController(rootViewController: vc)
            
            popupController?.present(in: self)
        }
        
        return nil
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return tableView.getSize().height * 0.4
        }
        
        return 100
    }
}







