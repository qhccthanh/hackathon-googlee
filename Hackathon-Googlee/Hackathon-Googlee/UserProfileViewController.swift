//
//  UserProfileViewController.swift
//  Hackathon-Googlee
//
//  Created by Quach Ha Chan Thanh on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController : UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var phonenumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.allowsEditingTextAttributes = false
        email.allowsEditingTextAttributes = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func updateProfile(_ sender: AnyObject!) {
        
        // Check birthday
        if let birthday = self.birthday.text {
            
            let birthdayInt = Int(birthday)
            
            if let hasBirthday = birthdayInt {
                if (hasBirthday < 1960 || hasBirthday > 2016) {
                    Utility.showToastWithMessage("Năm sinh bị sai")
                    return
                }
            } else {
                Utility.showToastWithMessage("Năm sinh không thể chứa kí tự")
                return
            }
        } else {
            
        }
        
        // Check phone number
        if let phonenumber = self.phonenumber.text {
            
            let phone = Int(phonenumber)
            
            if phone != nil {
                if (phonenumber.length() < 9 || phonenumber.length() > 12) {
                    Utility.showToastWithMessage("Số điện thoại không hợp lệ")
                    return
                }
            } else {
                Utility.showToastWithMessage("Số điện thoại không thể chứa kí tự")
                return
            }
        } else {
            
        }
        
        // Gửi lên firebase
    }
    
    @IBAction func cleanAll(_ sender: AnyObject!) {
        birthday.text = ""
        gender.selectedSegmentIndex = 0 // male
        phonenumber.text = ""
    }
}
