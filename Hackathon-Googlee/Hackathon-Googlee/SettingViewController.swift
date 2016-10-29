//
//  SettingViewController.swift
//  Hackathon-Googlee
//
//  Created by Quach Ha Chan Thanh on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import UIKit


class SettingViewController: CTViewController {
    
    let cellIdentifier = ["UserInfoCell", "InfoCell", "SignOutCell"]
    var settingDataSources: [Any] = [
        [],
        [
            (image: UIImage(named: "Create New-96"), title: "Thay đổi thông tin cá nhân"),
         (image:  UIImage(named: "Joining Queue Filled-50"), title: "Các sự kiện đã tham gia"),
         (image:  UIImage(named: "Christmas Star"), title: "Các sự kiện đang quan tâm"),
         (image:  UIImage(named: "Phone-96"), title: "Liên hệ"),
         (image:  UIImage(named: "Link-48"), title: "Chia sẽ"),
        ],
        [],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signOutAction(sender: AnyObject!) {
    
    }

}

extension SettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingDataSources.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == settingDataSources.count - 1  {
            return 1
        }
        
        return (settingDataSources[section] as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier[indexPath.section])!
        
        if indexPath.section != 0 && indexPath.section != settingDataSources.count - 1 {
             let item = (settingDataSources[indexPath.section] as! [Any])[indexPath.row] as! (image: UIImage?, title: String)
            
            if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
                imageView.image = item.image
            }
            
            if let textCell = cell.contentView.viewWithTag(2) as? UILabel {
                textCell.text = item.title
            }
        }
        
        return cell
    }
    
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0  {
            return 55
        }
        
        if indexPath.section == settingDataSources.count - 1 {
            return 40
        }
        
        return 55
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
