//
//  UIView+Extension.swift
//  TFDictionary
//
//  Created by qhcthanh on 7/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func getSize() -> CGSize {
        return frame.size
    }
    
    func getOrigin() -> CGPoint {
        return frame.origin
    }
    
    func getRightX() -> CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    func getBottomY() -> CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    func setCenterVerticalInSize(_ size: CGSize) {
        self.frame.origin.y = size.height/2 - getSize().height/2
    }
    
    func setCenterHorizontalInSize(_ size: CGSize) {
        self.frame.origin.x = size.width/2 - getSize().width/2
    }
    
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var rectShadow: Bool {
        set {
            if newValue {
                setRectShadow()
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 0)
                layer.shadowRadius = 0
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0")) {
                    //self.layer.shadowOpacity = 0.0
                }
                layer.masksToBounds = false
                clipsToBounds = false
            }
            
        }
        get {
            if layer.shadowOpacity == 1.0 {
                return true
            } else {
                return false
            }
        }
    }
    
    func setRectShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0")) {
            self.layer.shadowOpacity = 1.0
        }
        layer.masksToBounds = false
        clipsToBounds = false
    }
}


extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController , top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
}

extension UINavigationBar {
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.isHidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.isHidden = false
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
}

