//
//  SoundManager.swift
//  TFDictionary
//
//  Created by Quach Ha Chan Thanh on 7/24/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

import Foundation
import AVFoundation

let answer_fail = "answer_fail"
let answer_right = "answer_right"
let touchSound = "touch"
let rootAPISoundString = "http://ssl.gstatic.com/dictionary/static/sounds/de/0/"

//let musicPath = dictionaryPath + "/speak"
class SoundManager {
    
    
    class func runSound(_ soundName: String) {
        let soundName = soundName.replacingOccurrences(of: ".mp3", with: "")
        let alertSound = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        var sound :SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(alertSound! as CFURL, &sound)
        AudioServicesPlaySystemSound(sound);
    }
    
    class func runSoundWithURL(_ url: URL) {
        var sound :SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(url as CFURL, &sound)
        AudioServicesPlaySystemSound(sound);
    }
    
    class func playSoundWithPath(_ path: String) {
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: path) {
            if let contentURL = URL(string: path) {
                SoundManager.runSoundWithURL(contentURL)
            } else {
             let _ = try? fileManager.removeItem(atPath: path)
            }

//            if let av = try? AVAudioPlayer(contentsOfURL: contentURL) {
//                av.play()
//            } else {
//                try? fileManager.removeItemAtPath(path)
//            }
        }
    }
    
//    class func playSpeakText(_ word: String, completion: @escaping () -> Void ) {
//        let fileManager = FileManager()
//        if fileManager.fileExists(atPath: musicPath) {
//            
//            let downloader = TCBlobDownloadManager()
//            let soundWordPath = "\(musicPath)/\(word).mp3"
//            
//            if fileManager.fileExists(atPath: soundWordPath) {
//                SoundManager.playSoundWithPath(soundWordPath)
//                return
//            }
//            
//            if !Utility.isConnectedToNetwork() {
//                completion()
//                return 
//            }
//            
//            let downloadMusicURL = "\(rootAPISoundString)\(word).mp3"
//            downloader.startDownload(with: URL(string: downloadMusicURL), customPath:  musicPath, firstResponse: { (_) in
//                
//                }, progress: { (_, _, _, _) in
//                    
//                }, error: { (error) in
//                    print(error)
//                    completion()
//                }, complete: { (success, path) in
//                    print("DownMusic \(word) Success at Path: \(path)")
//                    if let path = path , fileManager.fileExists(atPath: path) {
//                        SoundManager.playSoundWithPath(path)
//                    } else {
//                        if let path = path {
//                            let _ = try? fileManager.removeItem(atPath: path)
//                        }
//                        completion()
//                    }
//            })
//            
//        } else {
//            print("Create fail")
//            completion()
//        } 
//    }
    
    
}
