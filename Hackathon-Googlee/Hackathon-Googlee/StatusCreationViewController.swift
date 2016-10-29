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
import Photos

class CBButton: UIButton {
    
    var id: Int!
    
}

class StatusCreationViewController: CTViewController {
    
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var imaegCollectionView: UICollectionView!
    
    @IBOutlet weak var numberPerson: UITextField!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    
    let imagePickerController = UIImagePickerController()
    var numberImages: [PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.categoriesButton.contentEdgeInsets = UIEdgeInsetsMake(categoriesButton.contentEdgeInsets.top, 8, categoriesButton.contentEdgeInsets.bottom, 8)
        self.locationButton.contentEdgeInsets = UIEdgeInsetsMake(categoriesButton.contentEdgeInsets.top, 8, categoriesButton.contentEdgeInsets.bottom, 8)
        self.imageButton.contentEdgeInsets = UIEdgeInsetsMake(categoriesButton.contentEdgeInsets.top, 8, categoriesButton.contentEdgeInsets.bottom, 8)
        
        textView.text = "Mô tả ..."
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func addStatusAction(_ sender: AnyObject!) {
        endEditing()
        if (LocationManager.locationManager.location != nil) {
            let dict = NSMutableDictionary()
            
            dict.setObject(textView.text, forKey: kContentKey as NSCopying)
            dict.setObject(Int.init(numberPerson.text!)!, forKey: kNumberOfPerson as NSCopying)
            dict.setObject(UserAccount.sharedInstance, forKey: kHostKey as NSCopying)
            dict.setObject(Date.timeIntervalSinceReferenceDate, forKey: kPostTimeKey as NSCopying)
            
            var categories = self.categoriesButton.currentTitle
            categories?.characters.removeFirst()
            
            let dict1 = NSMutableDictionary()
            
            var index = 0
            for string in (categories?.components(separatedBy: ", "))! {
                dict1.setValue(EnticementPost.categoryNameToNumber(name: string), forKey: "\(index)")
                
                print(string)
                print(index)
                index = index + 1
            }

            dict.setObject(dict1, forKey: kCategoriesKey as NSCopying)
            
            dict.setObject(LocationManager.locationManager.location.coordinate.latitude, forKey: kHostLatLocationKey as NSCopying)
            dict.setObject(LocationManager.locationManager.location.coordinate.longitude, forKey: kHostLongLocationKey as NSCopying)
            dict.setObject(0, forKey: kInterestedListKey as NSCopying)
            dict.setObject(0, forKey: kJoinedListKey as NSCopying)

            
            let newPost = EnticementPost.init(withDictionary: dict)
            EnticementPostManager.manager.add(newItem: newPost)
            
            print(newPost)
            newPost.pushData2Server()
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    
    @IBAction func pickCategoriesAction(_ sender: AnyObject!) {
        endEditing()
    }
    
    @IBAction func pickImageAction(_ sender: AnyObject!) {
        endEditing()
        if #available(iOS 8.0, *) {
            
            let alertController = UIAlertController(title: "Googlee".localized, message: "Chọn chế độ", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Chọn hình trong thư viện".localized, style: .default, handler: { (_) in
                self.imagePickerController.sourceType = .photoLibrary
                
//                self.navigationController?.present(self.imagePickerController, animated: true, completion: nil)
//                let vc = BSImagePickerViewController()
//                
//                self.bs_presentImagePickerController(vc, animated: true,
//                                                select: { (asset: PHAsset) -> Void in
//                                                    // User selected an asset.
//                                                    // Do something with it, start upload perhaps?
//                    }, deselect: { (asset: PHAsset) -> Void in
//                        // User deselected an assets.
//                        // Do something, cancel upload?
//                    }, cancel: { (assets: [PHAsset]) -> Void in
//                        // User cancelled. And this where the assets currently selected.
//                    }, finish: { (assets: [PHAsset]) -> Void in
//                        // User finished with these assets
//                        print(assets)
//                        self.numberImages = assets
//                        DispatchQueue.main.async {
//                            self.imaegCollectionView.reloadData()
//                        }
//                }, completion: nil)

            }))
            
            alertController.addAction(UIAlertAction(title: "Chụp ảnh mới".localized, style: .default, handler: { (_) in
                if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                    self.imagePickerController.sourceType = .camera
                    self.imagePickerController.cameraCaptureMode = .photo
                    self.imagePickerController.modalPresentationStyle = .fullScreen
                    
                    self.navigationController?.present(self.imagePickerController, animated: true, completion: nil)
                } else {
                    self.noCamera()
                }
            }))
            
            alertController.addAction(UIAlertAction(title: "Huỷ bỏ".localized, style: .cancel, handler: { (_) in
                alertController.dismiss(animated: true, completion: nil)
            }))
            
            self.navigationController?.present(alertController, animated: true, completion: nil)
            
        } else {
            Utility.showToastWithMessage("Thiết bị không hỗ trợ Camera".localized)
        }

    }
    
    func noCamera(){
        
        if #available(iOS 8.0, *) {
            let alertVC = UIAlertController(
                title: "Không có camera".localized,
                message: "Thiết bị không hỗ trợ Camera".localized,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: "Đồng ý".localized,
                style:.default,
                handler: nil)
            
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
            
        else {
            // Fallback on earlier versions
        }
    }
    
    var placePicker: GMSPlacePicker?
    
    @IBAction func pickPlaceAction(_ sender: AnyObject!) {
        endEditing()
        var center = CLLocationCoordinate2DMake(10.7639531, 106.6565973)
        if let location = LocationManager.locationManager.location {
            center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        }
        
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
                var address = ""
                if let addressT = place.formattedAddress {
                    address = addressT
                }
                
                self.locationButton.setTitle("\(place.name) - \(address)", for: .normal)
            } else {
                print("No place selected")
            }
        })   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickCategories" {
            if let vc = segue.destination as? CategoriesTableViewController {
                vc.baseVC = self
            }
        }
    }
    
}

extension StatusCreationViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
           // self.ocrImageView.image = image
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension StatusCreationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        let imagePH = self.numberImages[indexPath.row]
        
        if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
            imageView.image = getAssetThumbnail(asset: imagePH)
        }
        
        return cell
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
}

extension StatusCreationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.getSize().width / 3 - 5 ,height: (collectionView.getSize().width / 3 - 5) * 4 / 3 )
    }

    
}

