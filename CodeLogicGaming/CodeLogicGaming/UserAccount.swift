//
//  UserAccount.swift
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit
import Firebase

enum Sex : Int {
    case Male = 1
    case Female
}

class UserAccount: NSObject {
   
    // Properies
    var userID: String?
    var userName: String?
    var avatarURL: String?
    var email: String?
    var phoneNumber: String?
    var sex: Sex?
    var birthDay: Double?
    
    let kUserIDKey = "userID"
    let kUserNameKey = "userName"
    let kAvatarURLKey = "avatarURL"
    let kEmailKey = "email"
    let kPhoneNumberKey = "phoneNumber"
    let kSexKey = "sex"
    let kBirthDayKey = "birthDay"
    
    override init() {
        super.init()
    }
    
    init(withDictionary data: NSDictionary) {
        super.init()
        
        self.userID = data.object(forKey: kUserIDKey) as? String
        self.userName = data.object(forKey: kUserNameKey) as? String
        self.avatarURL = data.object(forKey: kAvatarURLKey) as? String
        self.phoneNumber = data.object(forKey: kPhoneNumberKey) as? String
        self.sex = data.object(forKey: kSexKey) as? Sex
        self.birthDay = data.object(forKey: kBirthDayKey) as? Double
    }
}
