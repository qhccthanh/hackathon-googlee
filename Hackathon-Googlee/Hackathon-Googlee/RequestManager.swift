//
//  RequestManager.swift
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit
import Firebase


extension NSNotification.Name {
    static let UserLoggedIn: NSNotification.Name = NSNotification.Name(rawValue: "kNotificationUserLoggedIn")
}

class RequestManager: NSObject {

    var rootRef: FIRDatabaseReference?
    var authStateDidChangeListenerHandle: FIRAuthStateDidChangeListenerHandle?
    
    static let sharedInstance = RequestManager()

    private override init() {
        super.init()
        
        self.rootRef = FIRDatabase.database().reference().child(kRootKey)
        self.authStateDidChangeListenerHandle = self.addAuthStateDidChangeListener()
    }
    
    func addAuthStateDidChangeListener() -> FIRAuthStateDidChangeListenerHandle? {
        
        let authStateDidChangeListener: FIRAuthStateDidChangeListenerHandle? = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
            if (user != nil) {
                
                for profile in user!.providerData {
                    let userRef = self.rootRef?.child(kUsersKey).child(user!.uid)
                    
                    userRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                        var data: NSDictionary = NSDictionary()
                        
                        if (!snapshot.exists()) {
                            data = [
                                kUserIDKey:        user!.uid,
                                kUserNameKey:      profile.displayName!,
                                kAvatarURLKey:     (profile.photoURL != nil) ? profile.photoURL!.absoluteString : "",
                                kEmailKey:         profile.email!,
                                kPhoneNumberKey: "",
                                kSexKey: "Male",
                                kBirthDayKey: 0
                            ]
                            self.insert(child: (user?.uid)!, withData: data, toPath: kUsersKey)
                        }
                        NotificationCenter.default.post(name: .UserLoggedIn, object: nil, userInfo: data as? [AnyHashable : Any])
                    })
                }
            }
        })
        
        return authStateDidChangeListener
    }
    
    func selectDataFrom(path: String, completionBlock:((NSDictionary?) -> Void)?) {
        self.selectDataFrom(path: path, completionBlock: completionBlock, cancelBlock: nil)
    }
    
    func selectDataFrom(path: String, completionBlock:((NSDictionary?) -> Void)?, cancelBlock:((NSError?) -> Void)?) {
        
        let dbRef = self.rootRef?.child(path)
        
        dbRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                completionBlock?(snapshot.value as? NSDictionary)
            }, withCancel: { (error) in
                cancelBlock?(error as NSError?)
        })
    }
    
    func insert(child: String, withData data: Any, toPath path: String) {
        
        var dbRef = self.rootRef?.child(path)
        
        dbRef = dbRef?.child(child)
        dbRef?.setValue(data)
    }
    
    func insert(child: String, withData data: Any, toPath path: String, withCompletion completionBlock: ((NSError?) -> Void)?) {
        
        var dbRef = self.rootRef?.child(path)
        
        dbRef = dbRef?.child(child)
        dbRef?.setValue(data, withCompletionBlock: { (error, ref) in
            completionBlock?(error as? NSError)
        })
    }
    
    func insertChildByAutoID(withData data: Any, toPath path: String) -> String? {
        
        var dbRef = self.rootRef?.child(path)
        dbRef = dbRef?.childByAutoId()
        dbRef?.setValue(data)
        
        return dbRef?.key
    }
    
    func getAutoID(withPath path: String) -> String? {
        
        var dbRef = self.rootRef?.child(path)
        dbRef = dbRef?.childByAutoId()
        
        return dbRef?.key
    }
    
    func observeData(fromPath path: String, withEvent event: FIRDataEventType, completion completionBlock: ((NSDictionary?) -> Void)?) -> FIRDatabaseHandle {
        
        let dbRef = self.rootRef?.child(path)
        let dbHandle = dbRef?.observe(event, with: { (snapshot) in
            completionBlock?([snapshot.key : snapshot.value])
        })
        
        return dbHandle!
    }
    
    func removeObserver(withHandle handle: FIRDatabaseHandle) {
        self.rootRef?.removeObserver(withHandle: handle)
    }
    
    func setValue(atPath path: String, withData data: Any) {
        let dbRef = self.rootRef?.child(path)
        
        dbRef?.setValue(data)
    }
    
}
