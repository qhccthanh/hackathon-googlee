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
    case DiChoiXa
    case ThamGiaSuKien
    case ChuyenDo
}

protocol EnticementPostProtocol: class {
    func getHost() -> UserAccount?
    func getPostTime() -> Double?
    func getContent() -> String?
    func getCategories() -> Array<Category>?
    func getHostLocation(completion: ((String?) -> Void)?)
    func getInterestedList() -> Array<UserAccount>?
    func getJoinedList() -> Array<UserAccount>?
}

let kHostKey = "hostID"
let kPostTimeKey = "postTime"
let kContentKey = "content"
let kCategoriesKey = "categories"
let kHostLatLocationKey = "hostLatLocation"
let kHostLongLocationKey = "hostLongLocation"
let kInterestedListKey = "interestedList"
let kJoinedListKey = "joinedList"

class EnticementPost: NSObject, EnticementPostProtocol {
    
    // Properties
    var host: UserAccount?
    var postTime: Double? // Time interval since 1970
    var content: String?
    var categories: Array<Category>! = Array()
    var hostLatLocation: Double?
    var hostLongLocation: Double?
    var interestedList: Array<UserAccount>! = Array() // Nhưng người có hứng thú vs post này
    var joinedList: Array<UserAccount>! = Array() // Danh sách người đã đăng ký
    
    override init() {
        super.init()
    }
    
    init(withDictionary data: NSDictionary) {
        super.init()
        
        self.host = data.object(forKey: kHostKey) as? UserAccount
        self.postTime = data.object(forKey: kPostTimeKey) as? Double
        self.content = data.object(forKey: kContentKey) as? String
        self.categories = (data.object(forKey: kCategoriesKey) as? NSDictionary)?.allValues as? Array<Category>
        self.hostLatLocation = data.object(forKey: kHostLatLocationKey) as? Double
        self.hostLongLocation = data.object(forKey: kHostLongLocationKey) as? Double
        
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
        self.hostLatLocation = data.object(forKey: kHostLatLocationKey) as? Double
        self.hostLongLocation = data.object(forKey: kHostLongLocationKey) as? Double
        
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
    
    func getHost() -> UserAccount? {
        return host
    }
    func getPostTime() -> Double? {
        return postTime
    }
    func getContent() -> String? {
        return content
    }
    func getCategories() -> Array<Category>? {
        return categories
    }
    func getJoinedList() -> Array<UserAccount>? {
        return joinedList
    }
    func getInterestedList() -> Array<UserAccount>? {
        return interestedList
    }
    func getHostLocation(completion: ((String?) -> Void)?) {
       
        let webServiceURL = URL.init(string: "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + "\(hostLatLocation)" + "," + "\(hostLongLocation)")

        if (self.hostLongLocation == nil || self.hostLongLocation == nil || webServiceURL == nil) {
            completion?(nil)
        }
        
        _ = URLSession.shared.dataTask(with: webServiceURL!) { (data, response, error) in
            if (error != nil || data == nil) {
                completion?(nil)
            }
            
            let dicData: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary).value(forKey: "results") as! NSDictionary
            completion?(dicData.value(forKey: "formatted_address") as! String?)
        }
    }
}

