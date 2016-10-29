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
    var datasources: [EnticementPostProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.isMyLocationEnabled = true
        if let location = LocationManager.locationManager.location {
            let target = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 15)
        } else {
            print("User's location is unknown")
            let target = CLLocationCoordinate2D(latitude: 10.7639531, longitude: 106.6565973)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 10)
            
            let position = CLLocationCoordinate2DMake(10.7639531, 106.6565973)
            let marker = GMSMarker(position: position)
            marker.title = "Con chim non, trên cành cao, hót líu lo, hót líu lo, em yêu chiêm, em mến chiêm, vì mỗi lần chiêm hót em vuôi"
            marker.map = mapView
            
//            let position2 = CLLocationCoordinate2DMake(10.7639531, 106.6565973)
//            let marker2 = GMSMarker(position: position)
//            marker2.title = "Con chim non, trên cành cao, hót líu lo, hót líu lo, em yêu chiêm, em mến chiêm, vì mỗi lần chiêm hót em vuôi"
//            marker2.map = mapView
//            
//            let origin = CLLocationCoordinate2D(latitude: 10.7639531, longitude: 106.6565973)
//            let dest = CLLocationCoordinate2D(latitude: 10.755512, longitude: 106.685809)
//            let t = GoogleMapDirector()
//            t.showDirection(originMarker: marker as! CTMarker, destinationMarker: marker2 as! CTMarker, mapView: mapView)
//            
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
        
        return self.datasources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        cell = (indexPath.section == 0 ? tableView.dequeueReusableCell(withIdentifier: "MapViewCell") : tableView.dequeueReusableCell(withIdentifier: "InfoCell"))!
        
        if indexPath.section == 0 {
            if let mapView = cell.contentView.subviews.first as? GMSMapView {
                self.mapView = mapView
            }
        } else {
            
            for var i in 1...8 {
                if let button = cell.contentView.viewWithTag(i) as? CBButton, i < 5 {
                    
                    button.id = indexPath.row
                    if i == 4 {
                        button.addTarget(self, action: #selector(self.touchLocationCellAction), for: .touchUpInside)
                    } else if i == 1 {
                        button.addTarget(self, action: #selector(self.touchBookmarkCellAction(_:)), for: .touchUpInside)
                    } else if i == 2 {
                        button.addTarget(self, action: #selector(self.touchJoinCellAction(_:)), for: .touchUpInside)
                    }else {
                        button.addTarget(self, action: #selector(self.touchShareCellAction(_:)), for: .touchUpInside)
                    }
                    
                } // 5 -> 7 content, tag, location
                else if let label = cell.contentView.viewWithTag(i) as? UILabel, i < 8 {
                    
                   label.text = "Hỗ Báo Hỗ Báo"
                } else if let imageView = cell.contentView.viewWithTag(i) as? UIImageView {
                    //
                    imageView.image = UIImage(named: "Left Footprint-96")
                }
                
                
            }
            
         
        }
        
        return cell
    }
    
    func touchLocationCellAction(_ sender: CBButton!) {
        let id = sender.id
        // item
    }
    
    func touchJoinCellAction(_ sender: CBButton!) {
        let id = sender.id
        if sender.currentImage == UIImage(named: "Joining Queue Filled-50") {
            sender.setImage(UIImage(named: "Joining Queue-50"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "Joining Queue Filled-50"), for: .normal)
        }
    }
    
    func touchShareCellAction(_ sender: CBButton!) {
        let id = sender.id
        
    }
    
    func touchBookmarkCellAction(_ sender: CBButton!) {
        let id = sender.id
        if sender.currentImage == UIImage(named: "Christmas Star") {
            sender.setImage(UIImage(named: "Christmas StarUn"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "Christmas Star"), for: .normal)
        }
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
            return tableView.getSize().height * 0.45
        }
        
        return 100
    }
}







