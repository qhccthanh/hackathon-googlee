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
  //  var datasources: [EnticementPostProtocol] = []
//    case ChoiGame = 0
//    case DiAn
//    case DiDuLich
//    case CungNhauGapMat
//    case ChuyenDo
//    case TanGau
//    case CungNhauDiSuKien
    func abccc(abc: Int) -> Category {
        switch abc {
        case 0:
            return .ChoiGame
        case 1:
            return .DiAn
        case 2:
            return .DiDuLich
        case 3:
            return .CungNhauGapMat
        case 4:
            return .ChuyenDo
        case 5:
            return .TanGau

        default:
            return .CungNhauDiSuKien
        }
    }
    
    var flag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView?.dataSource = self
        
        RequestManager.sharedInstance.selectDataFrom(path: kEnticementPosts) { (data) in
            if data != nil {
                for (postKey, postValue) in data! {
                    
                    let dict = NSMutableDictionary()
                    if let postValue = postValue as? NSDictionary {
                        dict.setObject(postKey, forKey: kPostIDKey as NSCopying)
                        dict.setObject(postValue[kContentKey], forKey: kContentKey as NSCopying)
                        dict.setObject(postValue[kNumberOfPerson], forKey: kNumberOfPerson as NSCopying)
                        dict.setObject(UserAccount.init(withDictionary: postValue[kHostKey] as! NSDictionary), forKey: kHostKey as NSCopying)
                        dict.setObject(postValue[kPostTimeKey], forKey: kPostTimeKey as NSCopying)
                        
                        let dict1 = (postValue[kCategoriesKey] as! NSArray)
                        var newdick = [Category]()
                        
                        for item in dict1 {
                            newdick.append(self.abccc(abc: item as! Int))
                        }
                        
                        dict.setObject(newdick, forKey: kCategoriesKey as NSCopying)
                        
                        dict.setObject(postValue[kHostLongLocationKey], forKey: kHostLongLocationKey as NSCopying)
                        dict.setObject(postValue[kHostLatLocationKey], forKey: kHostLatLocationKey as NSCopying)
                        
                        dict.setObject(0, forKey: kInterestedListKey as NSCopying)
                        dict.setObject(0, forKey: kJoinedListKey as NSCopying)
                        
                        let newPost = EnticementPost.init(withDictionary: dict)
                        EnticementPostManager.manager.add(newItem: newPost)
                        
                        
                    }
                }
                DispatchQueue.main.async {
                    print(self.tableView)
                    self.tableView?.reloadData()
                    self.flag = true
                }
            }
        }
        
            _ = RequestManager.sharedInstance.observeData(fromPath: kEnticementPosts, withEvent: .childAdded) { (data) in
                
                if data != nil && self.flag == true {
                    for (postKey, postValue) in data! {
                        
                        let dict = NSMutableDictionary()
                        if let postValue = postValue as? NSDictionary {
                            dict.setObject(postKey, forKey: kPostIDKey as NSCopying)
                            dict.setObject(postValue[kContentKey], forKey: kContentKey as NSCopying)
                            dict.setObject(postValue[kNumberOfPerson], forKey: kNumberOfPerson as NSCopying)
                            dict.setObject(UserAccount.init(withDictionary: postValue[kHostKey] as! NSDictionary), forKey: kHostKey as NSCopying)
                            dict.setObject(postValue[kPostTimeKey], forKey: kPostTimeKey as NSCopying)
                            
                            let dict1 = (postValue[kCategoriesKey] as! NSArray)
                            var newdick = [Category]()
                            
                            for item in dict1 {
                                newdick.append(self.abccc(abc: item as! Int))
                            }
                            
                            dict.setObject(newdick, forKey: kCategoriesKey as NSCopying)
                            
                            dict.setObject(postValue[kHostLongLocationKey], forKey: kHostLongLocationKey as NSCopying)
                            dict.setObject(postValue[kHostLatLocationKey], forKey: kHostLatLocationKey as NSCopying)
                            
                            dict.setObject(0, forKey: kInterestedListKey as NSCopying)
                            dict.setObject(0, forKey: kJoinedListKey as NSCopying)
                            
                            let newPost = EnticementPost.init(withDictionary: dict)
                            EnticementPostManager.manager.add(newItem: newPost)
                            
                            
                        }
                    }
                    DispatchQueue.main.async {
                        print(self.tableView)
                        self.tableView?.reloadData()
                    }
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.isMyLocationEnabled = true
        if let location = LocationManager.locationManager.location {
            let target = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 16)
        } else {
            print("User's location is unknown")
            let target = CLLocationCoordinate2D(latitude: 10.7639531, longitude: 106.6565973)
            mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 16)
            
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
    
    @IBAction func moveToMyLocation(_ sender: AnyObject!) {
        if let location = LocationManager.locationManager.location {
            
            self.mapView.animate(to: GMSCameraPosition(target: CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude), zoom: 16, bearing: 0, viewingAngle: 0))
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
        print(EnticementPostManager.manager.list.internalArray.count)
        return EnticementPostManager.manager.list.internalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell: UITableViewCell
        cell = (indexPath.section == 0 ? tableView.dequeueReusableCell(withIdentifier: "MapViewCell") : tableView.dequeueReusableCell(withIdentifier: "InfoCell"))!
        
        if indexPath.section == 0 {
            if let mapView = cell.contentView.subviews.first as? GMSMapView {
                self.mapView = mapView
            }
        } else {
            
            let itemData: EnticementPost = EnticementPostManager.manager.list.internalArray[indexPath.row] as! EnticementPost
            
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
                    
                    switch i {
                    case 5:
                        label.text = itemData.getContent()
                    case 6:
                        var newText = ""
                        
                        if let abc = itemData.getCategories() {
                            for category in abc {
                                newText = newText + EnticementPost.categoryNumberToName(num: category.rawValue)
                                newText = newText + ", "
                            }
                        }
                        if newText != "" {
                            newText.characters.removeLast()
                            newText.characters.removeLast()
                        }
                        
                        label.text = newText
                        
                    default:
                        itemData.getHostLocation(completion: { (string) in
                            DispatchQueue.main.async {
                                label.text = string                            }
                        })
                    }
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
        
        if let item = EnticementPostManager.manager.list.internalArray[id!] as? EnticementPost {
            let location = CLLocationCoordinate2D(latitude: item.hostLatLocation!, longitude: item.hostLongLocation!)
            
            mapView.animate(to: GMSCameraPosition(target: location, zoom: 16, bearing: 0, viewingAngle: 0))
        }
        
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
        
//        if let vc = Utility.getViewControllerWithClass(StatusDetailViewController.classForCoder()) {
//            let popupController = STPopupController(rootViewController: vc)
//            
//            popupController?.present(in: self)
//        }
        
        return nil
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return tableView.getSize().height * 0.45
        }
        
        return 100
    }
}







