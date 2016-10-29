//
//  Int+Extension.swift
//  TFDictionary
//
//  Created by Quach Ha Chan Thanh on 7/24/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation

extension Int {
    static func random(_ min: UInt32, max: UInt32) -> Int
    {
        if min > max {
            return 0
        }
        srandom(UInt32(Date().timeIntervalSinceReferenceDate))
        
        return Int(min + arc4random_uniform(max - min))
    }
}
