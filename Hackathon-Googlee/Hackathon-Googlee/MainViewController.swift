//
//  MainViewController.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit


class MainViewController: CTViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = RequestManager.sharedInstance.observeData(fromPath: kEnticementPosts, withEvent: .val) { (data) in
            print(data)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.isMyLocationEnabled = true
        if let location = LocationManager.locationManager.location {
            let target = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 15)
        } else {
            print("User's location is unknown")
            let target = CLLocationCoordinate2D(latitude: -33.868, longitude: 151.208)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 15)
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
            
        } else {
            
        }
        
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if let vc = Utility.getViewControllerWithClass(StatusDetailViewController.classForCoder()) {
            self.navigationController?.pushViewController(vc, animated: true)
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







