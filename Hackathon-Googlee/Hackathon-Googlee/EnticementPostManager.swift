//
//  EnticementPostManager.swift
//  Hackathon-Googlee
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class EnticementPostManager: NSObject {
    var list: TSArray = TSArray()
    
    static let manager = EnticementPostManager()
    
    func add(newItem: EnticementPost!) {
        list.append(newItem: newItem)
    }
    
    func removeLast() {
        list.removeLast()
    }
    
    func removeAll() {
        list.removeAll()
    }

    
}
