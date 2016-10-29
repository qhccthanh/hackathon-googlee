//
//  EnticementPost
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit

enum Category : Int {
    
    case GapMat = 0
    case ChoiGame
    case DiDuLich
    case ThamGiaSuKien
    case ChuyenDo
    case TanGau
    case DiAn
    
}

class EnticementPost: NSObject {
    
    // Properties
    var host: UserAccount?
    var postTime: Double? // Time interval since 1970
    var content: String?
    var categories: Array<Category>! = Array()
    var hostLocation: Double?
    var interestedList: Array<UserAccount>! = Array() // Nhưng người có hứng thú vs post này
    var joinedList: Array<UserAccount>! = Array() // Danh sách người đã đăng ký
    
    let kHostKey = "hostID"
    let kPostTimeKey = "postTime"
    let kContentKey = "content"
    let kCategoriesKey = "categories"
    let kHostLocationKey = "hostLocation"
    let kInterestedListKey = "interestedList"
    let kJoinedListKey = "joinedList"
    
    override init() {
        super.init()
    }
    
    init(withDictionary data: NSDictionary) {
        super.init()
        
        self.host = data.object(forKey: kHostKey) as? UserAccount
        self.postTime = data.object(forKey: kPostTimeKey) as? Double
        self.content = data.object(forKey: kContentKey) as? String
        self.categories = (data.object(forKey: kCategoriesKey) as? NSDictionary)?.allValues as? Array<Category>
        self.hostLocation = data.object(forKey: kHostLocationKey) as! Double?
        
        if let interesteds = (data.object(forKey: kInterestedListKey) as? NSDictionary)?.allValues {
            for item in interesteds {
                self.interestedList?.append(item as! UserAccount)
            }
        }
        
        if let joineds = (data.object(forKey: kJoinedListKey) as? NSDictionary)?.allValues {
            for item in joineds {
                self.joinedList?.append(item as! UserAccount)
            }
        }
    }
    
    func updateData(withDictionary data: NSDictionary) {
        self.host = data.object(forKey: kHostKey) as? UserAccount
        self.postTime = data.object(forKey: kPostTimeKey) as? Double
        self.content = data.object(forKey: kContentKey) as? String
        self.categories = (data.object(forKey: kCategoriesKey) as? NSDictionary)?.allValues as? Array<Category>
        self.hostLocation = data.object(forKey: kHostLocationKey) as! Double?
        
        if let interesteds = (data.object(forKey: kInterestedListKey) as? NSDictionary)?.allValues {
            for item in interesteds {
                self.interestedList?.append(item as! UserAccount)
            }
        }
        
        if let joineds = (data.object(forKey: kJoinedListKey) as? NSDictionary)?.allValues {
            for item in joineds {
                self.joinedList?.append(item as! UserAccount)
            }
        }
    }
}
