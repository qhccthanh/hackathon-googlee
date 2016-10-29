//
//  LoginViewController.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Google
import Foundation
import UIKit


class LoginViewController: CTViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var logoImage: UIImageView?
    var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.googleLoginButton = GIDSignInButton(frame: CGRect.zero)
        self.googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.googleLoginButton)
        
        let topLayout = NSLayoutConstraint(item: self.googleLoginButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.logoImage, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 16)
        
        let centerX = NSLayoutConstraint(item: self.googleLoginButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        self.view.addConstraint(topLayout)
        self.view.addConstraint(centerX)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
}
