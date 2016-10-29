//
//  EnticementPost
//  CodeLogicGaming
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Googlee. All rights reserved.
//

import UIKit

public enum Category : Int {
    
    case ChoiGame = 0
    case DiAn
    case DiDuLich
    case CungNhauGapMat
    case ChuyenDo
    case TanGau
    case CungNhauDiSuKien
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

let kNumberOfPerson = "numberOfPerson"
let kHostKey = "hotUser"
let kPostTimeKey = "postTime"
let kContentKey = "content"
let kCategoriesKey = "categories"
let kHostLatLocationKey = "hostLatLocation"
let kHostLongLocationKey = "hostLongLocation"
let kInterestedListKey = "interestedList"
let kJoinedListKey = "joinedList"


let kPostIDKey = "postID"

class EnticementPost: NSObject, EnticementPostProtocol {

    // Properties
    var host: UserAccount?
    var numberOfPerson: Int?
    var postTime: Double? // Time interval since 1970
    var content: String?
    var categories: Array<Category>! =  Array<Category>()
    var hostLatLocation: Double?
    var hostLongLocation: Double?
    var interestedList: Array<UserAccount>! = Array() // Nhưng người có hứng thú vs post này
    var joinedList: Array<UserAccount>! = Array() // Danh sách người đã đăng ký
    var postID: String?
    
    override init() {
        super.init()
    }
    
    class func categoryNameToNumber(name: String) -> Category {
        switch name {
        case "Chơi game":
            return .ChoiGame
        case "Đi ăn":
            return .DiAn
        case "Đi du lịch":
            return .DiDuLich
        case "Cùng nhau gặp mặt":
            return .CungNhauGapMat
        case "Chuyển đồ":
            return .ChuyenDo
        case"Tán gẫu":
            return .TanGau
        default:
            return .CungNhauDiSuKien
        }
    }
    
    class func categoryNumberToName(num: Int) -> String{
        switch num {
        case 0:
            return "Chơigame"
        case 1:
            return "Đi ăn"
        case 2:
            return "Đi du lịch"
        case 3:
            return "Cùng nhau gặp mặt"
        case 4:
            return "Chuyển đồ"
        case 5:
            return "Tán gẫu"
        default:
            return "Cùng nhau đi sự kiện"
        }
    }
    
    init(withDictionary data: NSDictionary) {
        super.init()
        
        self.postID = data.object(forKey: kPostIDKey) as? String

        self.numberOfPerson = data.object(forKey: kNumberOfPerson) as? Int
        self.host = data.object(forKey: kHostKey) as? UserAccount
        self.postTime = data.object(forKey: kPostTimeKey) as? Double
        self.content = data.object(forKey: kContentKey) as? String
        
        print((data.object(forKey: kCategoriesKey) as? NSDictionary)?.allValues)
        
        if let temp =  data.object(forKey: kCategoriesKey) as? NSArray {
    
            for t in temp {
                if let t = t as? Hackathon_Googlee.Category {
                   self.categories.append(t)
                }
            }
        } else if let temp = data[kCategoriesKey] as? NSDictionary {
            self.categories = temp.allValues as! [Hackathon_Googlee.Category]
        }
        
       // self.categories =
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
        
        self.postID = data.object(forKey: kPostIDKey) as? String

        self.numberOfPerson = data.object(forKey: kNumberOfPerson) as? Int
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
    
    func getCategories() -> Array<Category>? {
        return categories
    }
    
    func pushData2Server() {
        //push host
        let child = RequestManager.sharedInstance.getAutoID(withPath: kEnticementPosts)
        let postDict = self.convert2Dictionary()
        
        RequestManager.sharedInstance.insert(child: child!, withData: postDict, toPath: kEnticementPosts)
        
    }
    
    func convert2Dictionary() -> NSDictionary{
        
        let postDict: NSMutableDictionary = NSMutableDictionary()
        
        let hostDict = self.host?.convert2Dictionary()
        
        var interestDictArr = Array<NSMutableDictionary>()
        var joinDictArr = Array<NSMutableDictionary>()
        var cateloriesArr = Array<Int>()
        
        
        for interest in self.interestedList {
            interestDictArr.append(interest.convert2Dictionary())
        }
        
        for joiner in self.joinedList {
            joinDictArr.append(joiner.convert2Dictionary())
        }
        
        for category in self.categories {
            let cateID = category.rawValue
            cateloriesArr.append(cateID)
        }
        
        postDict.setValue(self.postTime, forKey: kPostTimeKey)
        postDict.setValue(self.content, forKey: kContentKey)
        postDict.setValue(cateloriesArr, forKey: kCategoriesKey)
        postDict.setValue(self.hostLatLocation, forKey: kHostLatLocationKey)
        postDict.setValue(self.hostLongLocation, forKey: kHostLongLocationKey)
        postDict.setValue(interestDictArr, forKey: kInterestedListKey)
        postDict.setValue(joinDictArr, forKey: kJoinedListKey)
        postDict.setValue(self.numberOfPerson, forKey: kNumberOfPerson)
        
        postDict.setValue(hostDict, forKey: kHostKey)

        
        return postDict
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
    
    //    func getCategories() -> Array<Category>? {
    //        return categories
    //    }
    
    func getJoinedList() -> Array<UserAccount>? {
        return joinedList
    }
    func getInterestedList() -> Array<UserAccount>? {
        return interestedList
    }
    func getHostLocation(completion: ((String?) -> Void)?) {
        
        let webServiceURL = URL.init(string: "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + "\(hostLatLocation!)" + "," + "\(hostLongLocation!)")
        print(webServiceURL?.absoluteString)
        if (self.hostLongLocation == nil || self.hostLongLocation == nil || webServiceURL == nil) {
            completion?(nil)
            return
        }
        
        let session = URLSession.shared.dataTask(with: webServiceURL!) { (data, response, error) in
            if (error != nil || data == nil) {
                completion?(nil)
                return
            }
            
          //  let dicData: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary).value(forKey: "results") as! NSDictionary
            if let dicData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves),
                let dic = dicData as? NSDictionary,
                let value = dic["results"] as? NSArray {
                print(value)
                if let first = value.firstObject, let value = first as? NSDictionary {
                    completion?(value["formatted_address"] as! String?)
                }
                
            }
            
            
        }
        session.resume()
    }
}

