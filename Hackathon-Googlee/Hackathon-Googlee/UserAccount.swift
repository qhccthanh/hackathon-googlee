//
//  UserAccount.swift
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit
import Firebase


let kUserIDKey = "userID"
let kUserNameKey = "userName"
let kAvatarURLKey = "avatarURL"
let kEmailKey = "email"
let kPhoneNumberKey = "phoneNumber"
let kSexKey = "sex"
let kBirthDayKey = "birthDay"

protocol UserAccountProtocol : class {
    func getUserID() -> String?
    func getUserName() -> String?
    func getAvatarURL() -> String?
    func getEmail() -> String?
    func getPhoneNumber() -> String?
    func getSex() -> String?
    func getBirthDay() -> Int?
}

class UserAccount: NSObject , UserAccountProtocol {
   
    static var sharedInstance = UserAccount()
    
    // Properies
    var userID: String?
    var userName: String?
    var avatarURL: String?
    var email: String?
    var phoneNumber: String?
    var sex: String?
    var birthDay: Int?
    
    override init() {
        super.init()
    }
    
    init(withDictionary data: NSDictionary) {
        super.init()
        
        self.userID = data.object(forKey: kUserIDKey) as? String
        self.userName = data.object(forKey: kUserNameKey) as? String
        self.avatarURL = data.object(forKey: kAvatarURLKey) as? String
        self.phoneNumber = data.object(forKey: kPhoneNumberKey) as? String
        self.sex = data.object(forKey: kSexKey) as? String
        self.birthDay = data.object(forKey: kBirthDayKey) as? Int
    }
    
    func updateData(withDictionary data: NSDictionary) {
        self.userID = data.object(forKey: kUserIDKey) as? String
        self.userName = data.object(forKey: kUserNameKey) as? String
        self.avatarURL = data.object(forKey: kAvatarURLKey) as? String
        self.phoneNumber = data.object(forKey: kPhoneNumberKey) as? String
        self.sex = data.object(forKey: kSexKey) as? String
        self.birthDay = data.object(forKey: kBirthDayKey) as? Int
    }
    
    func pushData2Server(child: String, data: Any, path: String) {
        RequestManager.sharedInstance.insert(child: child, withData: data, toPath: path)
    }
    
    func convert2Dictionary() -> NSMutableDictionary{
        let resDict: NSMutableDictionary = NSMutableDictionary()
        
        resDict.setValue(self.userID, forKey: kUserIDKey)
        resDict.setValue(self.userName, forKey: kUserNameKey)
        resDict.setValue(self.avatarURL, forKey: kAvatarURLKey)
        resDict.setValue(self.email, forKey: kEmailKey)
        resDict.setValue(self.phoneNumber, forKey: kPhoneNumberKey)
        resDict.setValue(self.sex, forKey: kSexKey)
        resDict.setValue(self.birthDay, forKey: kBirthDayKey)
        
        
        return resDict
    }
    
    func getUserID() -> String? {
        return self.userID
    }
    func getUserName() -> String? {
        return self.userName
    }
    func getAvatarURL() -> String? {
        return avatarURL
    }
    func getEmail() -> String? {
        return email
    }
    func getSex() -> String? {
        return sex
    }
    func getBirthDay() -> Int? {
        let formatter = DateFormatter()
        let date = Date()
        
        formatter.dateFormat = "yy"
        return Int.init(formatter.string(from: date))
        
    }
    func getPhoneNumber() -> String? {
        return phoneNumber
    }
}
