//
//  CategoriesTableViewController.swift
//  Hackathon-Googlee
//
//  Created by Quach Ha Chan Thanh on 10/29/16.
//  Copyright © 2016 Quach Ha Chan Thanh. All rights reserved.
//

import Foundation

class CategoriesTableViewController: CTViewController {
    
    var categories = [
        (rawValue: Category.ChoiGame,Title: "Chơi game",image: UIImage(named: "Joker-104")),
        (rawValue: Category.ChuyenDo,Title: "Chuyển đồ",image: UIImage(named: "Move by Trolley-104")),
        (rawValue: Category.DiAn,Title: "Đi ăn",image: UIImage(named: "Restaurant-96")),
        (rawValue: Category.DiDuLich,Title: "Đi du lịch",image: UIImage(named: "Left Footprint-96")),
        (rawValue: Category.CungNhauGapMat,Title: "Cùng nhau gặp mặt",image: UIImage(named: "Collaboration-100")),
        (rawValue: Category.TanGau,Title: "Tán gẫu",image: UIImage(named: "Chat Filled-100")),
        (rawValue: Category.CungNhauDiSuKien,Title: "Cùng tham gia sự kiện",image: UIImage(named: "Champagne-96")),
    ]
    
    @IBOutlet weak var categoriesTableView: UITableView!
    weak var baseVC: StatusCreationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.allowsMultipleSelectionDuringEditing = true
        categoriesTableView.isEditing = true
    }
    
    override func backAction(_ sender: AnyObject) {
        super.backAction(sender)
        if let selectRowsIndexPath = categoriesTableView.indexPathsForSelectedRows {
            var result = ""
            var count = 0
            for indexPath in selectRowsIndexPath{
                result += " \(categories[indexPath.row].Title)"
                count += 1
                if count != selectRowsIndexPath.count {
                    result += ","
                }
            }
            result = result == "" ? "Chọn loại..." : result
            baseVC.categoriesButton.setTitle(result, for: .normal)
        }
        
    }
}

extension CategoriesTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")!
        
        let item = categories[indexPath.row] 
        if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
            imageView.image = item.image
        }
        
        if let textCell = cell.contentView.viewWithTag(2) as? UILabel {
            textCell.text = item.Title
        }

        
        return cell
    }
    
}

extension CategoriesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
}



