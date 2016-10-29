//
//  Utility.swift
//  TFDictionary
//
//  Created by qhcthanh on 7/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SystemConfiguration

var messageNotification: String = "We miss you..."

class Utility {
    
    static let speechSynthesizer = AVSpeechSynthesizer()
   
    
    class func createColorWithRed(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    class func getViewControllerWithClass(_ aClass: AnyClass) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var temp = NSStringFromClass(aClass)
        temp = temp.components(separatedBy: ".").last!
        return storyboard.instantiateViewController(withIdentifier: temp)
    }
    
    class func showAlertWithMessage(_ title: String, message: String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        })
    }
    static var toast = JLToast()
    class func showToastWithMessage(_ mesage: String, duration: TimeInterval = JLToastDelay.ShortDelay) {
        toast.cancel()
        toast = JLToast.makeText(mesage, duration: duration)
        toast.show()
    }
    
    @available(iOS 8.0,*)
    class func showAlertWithMessageOKCancel(_ message: String,title: String,sender: UIViewController, doneAction: ( () -> Void )?, cancelAction: ( () -> Void )? ) {
        DispatchQueue.main.async(execute: {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                if let action = doneAction {
                    action()
                }
            }
            alert.addAction(okAction)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {
                action -> Void in
                if let action = cancelAction {
                    action()
                }
            }
            alert.addAction(cancelAction)
            sender.present(alert, animated: true, completion: { () in  })
        })
    }
    
    class func setupNotificationSettings() {
        // Specify the notification types.
        if #available(iOS 8.0, *) {
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.sound, UIUserNotificationType.alert, UIUserNotificationType.badge]
            let notificationSettings: UIUserNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)

            
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            // Fallback on earlier versions
        let notificationTypes: UIRemoteNotificationType = [.alert,.badge,.sound]
           UIApplication.shared.registerForRemoteNotifications(matching: notificationTypes)
        }
    }
    
    
//    
//    @available(iOS 8.0, *)
//    class func setupNotificationTimes(_ startHour: Int, endHour: Int, repeatNoti:Int = 100) {
//        
//        if(repeatNoti < 0) {
//            return
//        }
//        let startHour = startHour + 1
//        let endHour = endHour + 1
//
//        if startHour > endHour {
//            return
//        }
//        UIApplication.shared.cancelAllLocalNotifications()
//        
//        var deltaTime: Float = 0.0
//        if repeatNoti != 0 {
//            deltaTime = Float(abs(endHour - startHour)) / Float(repeatNoti)
//        }
//        
//        var comp = NSCalendar.current.dateComponents(in: TimeZone.current, from: Date())
//        comp.hour = startHour
//        comp.minute = 0
//        comp.second = 0
//        comp.nanosecond = 0
//        
//        let dateStartToFire = comp.date
//        
//        
//        print("start state: \(dateStartToFire!)")
//        
//        for step in 0...repeatNoti {
//            
//            let dateFire = dateStartToFire?.addingTimeInterval(Double(Float(step) * deltaTime * 60 * 60) )
//            print("Date noti: \(dateFire!)")
//            
//            let notification = UILocalNotification()
//            notification.fireDate = dateFire
//            notification.repeatInterval = NSCalendar.Unit.day
//            notification.soundName = UILocalNotificationDefaultSoundName
//            
//            let alertBody = getRandomWordRemind()
//            
//            if let body = alertBody.value(forKey: "content") as? String {
//                if(body != ""){
//                    notification.alertBody = body
//                    notification.timeZone = TimeZone.current
//                    notification.userInfo = ["word": alertBody.value(forKey: "word") as! String]
//                    UIApplication.shared.scheduleLocalNotification(notification)
//                    print("BODY NOTIFICATION: \(body)")
//                }
//            }
//        }
//        
//    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
//    class func queryTranslateWithString(controller: UIViewController, string: String, type: TFDictionaryType = .anhViet, completion: ((_ value: String) -> Void)?) {
//        
//        if string.length() == 0 {
//            Utility.showAlertWithMessage("VDict Dictionary", message: "Please enter your sentences.")
//            return
//        }
//        
//        if let word = DatabaseManager.searchCorrectWord(string, type: type) {
//            if let vc = Utility.getViewControllerWithClass(WordDetailViewController.self) as? WordDetailViewController {
//                vc.word = word
//                controller.navigationController?.pushViewController(vc, animated: true)
//                return
//            }
//        }
//        
//        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: controller.view, animated: true)
//        hud.mode = .indeterminate
//        hud.labelText = "Translating..."
//        hud.hide(true, afterDelay: 10)
//        
//        // Anh Viet la Anh -> Viet (Devi -> Vi)
//        let type = type == .anhViet ? "\(languageDrawRecognite)_vi" : "vi_\(languageDrawRecognite)"
//        var urlStr: String? = "text=\(string)&language=\(type)"
//        urlStr = "\(translateApi)\(urlStr!)"
//        urlStr = urlStr!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        
//        var task = URLSessionDataTask()
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        
//        task = session.dataTask(with: URL(string: urlStr!)!,completionHandler: {data,_,error in
//            DispatchQueue.main.async(execute: {
//                if let error = error {
//                    if error._code == URLError.notConnectedToInternet.rawValue {
//                        
//                        Utility.showToastWithMessage(kNoInternetConnectNotification)
//                    } else {
//                        Utility.showToastWithMessage("Have an error while translate sentences. Please try again.".localized)
//                    }
//                } else {
//                    if  let data = data {
//                        if let dataT = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary,
//                            let json = dataT {
//                            if let data = json["data"] as? String {
//                                //self.outputTextView.text = data
//                                //self.outputView.isHidden = false
//                                
//                                if let completion = completion {
//                                    completion(data)
//                                }
//                            }
//                        }
//                    }
//                }
//                hud.hide(true)
//            })
//        })
//        
//        task.resume()
//    }
    
}



