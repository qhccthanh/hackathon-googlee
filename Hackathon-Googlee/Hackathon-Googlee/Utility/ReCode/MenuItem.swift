//
//  MenuItem.swift
//  TFDictionary
//
//  Created by qhcthanh on 7/17/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    
    var title: String
    var image: UIImage?
    var navigateIdentifier: String?
    var navigateVC: AnyClass?
    var subTitile: String?
    var action: ((_ object: Any?) -> Void)?
    
    init(title: String, image: UIImage?, navigateID: String? , navigateVC: AnyClass?) {
        self.title = title
        self.image = image
        self.navigateIdentifier = navigateID
        self.navigateVC = navigateVC
    }
    
    init(title: String, subTitle: String, image: UIImage?, navigateVC: AnyClass?) {
        self.title = title
        self.image = image
        self.subTitile = subTitle
        self.navigateVC = navigateVC
    }
    
    init(title: String, subTitle: String, image: UIImage?, navigateID: String) {
        self.title = title
        self.image = image
        self.subTitile = subTitle
        self.navigateIdentifier = navigateID
    }
    
    init(title: String, image: UIImage?, navigateID: String? = nil) {
        self.title = title
        self.image = image
        self.navigateIdentifier = navigateID
    }
    
    init(title: String, image: UIImage?, navigateVC: AnyClass? = nil) {
        self.navigateVC = navigateVC
        self.title = title
        self.image = image
    }
    
    init(title: String, image: UIImage?, subtitle: String) {
        self.title = title
        self.image = image
        subTitile = subtitle
    }
    
    init(title: String, image: UIImage, action: ((_ object: Any?) -> Void)?) {
        self.title = title
        self.image = image
        self.action = action
    }
}
