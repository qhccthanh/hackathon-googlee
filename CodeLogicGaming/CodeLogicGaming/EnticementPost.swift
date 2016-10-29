//
//  EnticementPost
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit

enum Category {
    case GapMat
    case ChoiGame
    case DiChoiXa
    case ThamGiaSuKien
    case ChuyenDo
}

class EnticementPost: NSObject {
    
    // Properties
    var host: UserAccount = UserAccount()
    var postTime: Double = 0.0 // Time interval since 1970
    var content: String = ""
    var categories: Array<Category> = Array()
    var hostLocation: Double = 0.0
    var interestedList: Array<UserAccount> = Array() // Nhưng người có hứng thú vs post này
    var joinedList: Array<UserAccount> = Array() // Danh sách người đã đăng ký
    
    let kHostKey = "hostID"
    let kPostTimeKey = "postTime"
    let kContentKey = "content"
    let categoriesKey = "categories"
    
    
    override init() {
        super.init()
    }
    
    init(withDictionary data: NSDictionary) {
        super.init()
    }
}
