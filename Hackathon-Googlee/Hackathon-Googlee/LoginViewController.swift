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
import Firebase


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var logoImage: UIImageView?
    var googleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        self.googleLoginButton = UIButton(frame: CGRect.zero)
        self.googleLoginButton.setImage(UIImage(named: "btn_google_signin_light_pressed_web"), for: UIControlState.normal)
        self.googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.googleLoginButton.addTarget(self, action: #selector(signInGoogle), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(self.googleLoginButton)
        
        let topLayout = NSLayoutConstraint(item: self.googleLoginButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.logoImage, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 16)
        
        let centerX = NSLayoutConstraint(item: self.googleLoginButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        self.view.addConstraint(topLayout)
        self.view.addConstraint(centerX)
        
    }
    
    func signInGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
      //  myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            //self.showMessagePrompt(error.localizedDescription)
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                          accessToken: (authentication?.accessToken)!)
        // ...
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
        }
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
}
