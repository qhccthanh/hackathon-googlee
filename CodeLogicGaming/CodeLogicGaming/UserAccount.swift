//
//  UserAccount.swift
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit

enum Sex : Int {
    case Male = 1
    case Female
}

class UserAccount: NSObject {
   
    // Properies
    var userID: String = ""
    var userName: String = ""
    var avatarURL: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var sex: Sex = .Male
    var yearOfBirth: Int = 1900
    
    
}
