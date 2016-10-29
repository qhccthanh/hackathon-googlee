//
//  StatusCreationViewController.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit

class StatusCreationViewController: CTViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.text = "Mô tả ..."
    }
    
    @IBAction func addStatusAction(_ sender: AnyObject!) {
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
            
            print(dict)
            
            EnticementPostManager.manager.add(newItem: EnticementPost.init(withDictionary: dict))
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

