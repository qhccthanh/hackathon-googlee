//
//  TSArray.swift
//  Hackathon-Googlee
//
//  Created by MACMALL MF840 on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit

class TSArray: NSObject {
    var internalArray = NSMutableArray()
    private var serialQueue = DispatchQueue.init(label: "serialQueue")
    
    func append(newItem: Any!) {
        serialQueue.async {
            self.internalArray.add(newItem)
        }
    }
    func removeLast() {
        serialQueue.async {
            self.internalArray.removeLastObject()
        }
    }
    
    func removeAll() {
        serialQueue.async {
            self.internalArray.removeAllObjects()
        }
    }
    
    func objectAt(index: Int) -> Any? {
        var result: Any?
        serialQueue.sync {
            result = self.internalArray.object(at: index)
        }
        return result
    }
}
