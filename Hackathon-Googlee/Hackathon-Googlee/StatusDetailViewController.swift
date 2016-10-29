//
//  StatusDetailViewController.swift
//  Hackathon-Googlee
//
//  Created by VAN DAO on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit

class StatusDetailViewController: CTViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callAction(_ sender: AnyObject!) {
        Utility.showToastWithMessage("Người dùng này chưa cập nhật số điện thoại để liên lạc")
    }
    
    override func backAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
  
}

