//
//  String+Extension.swift
//  TFDictionary
//
//  Created by Quach Ha Chan Thanh on 7/23/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation


extension String {
    
    func length() -> Int {
        return self.characters.count
    }
    
    func isVietNamString() -> Bool {
        
        for c in characters {
            if let _ = mapVADictionary[String(c)] {
                return true
            }
        }
        
        return false
    }
    
    func toEnFromVietNamString() -> String {
        
        var stringTemp = ""
        
        for c in characters {
            if let str = mapVADictionary[String(c)] {
                stringTemp += str
            } else {
                stringTemp += String(c)
            }
        }
        
        return stringTemp
    }
    
    static func getStringInBunlde(fileName: String, ofType: String) -> String? {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: ofType),
            let fileString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8){
            return fileString
        }
        
        return nil
    }
    
    var localized: String {
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

}

extension UILabel {
    
//    func requiredHeight() -> CGFloat {
//        
//        //text!.boundingRectWithSize(self.frame.size, options: .UsesFontLeading, attributes: [NSFontAttributeName: font], context: nil)
//    }
}
