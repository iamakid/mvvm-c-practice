//
//  TodoTableViewCell.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/6/4.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit
import SnapKit

class TodoTableViewCell: UITableViewCell {

    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let selectedImg = UIColor.yellow.image()
        let disSelectedImg = UIColor.clear.image()
        
        button.setBackgroundImage(selectedImg, for: .selected)
        button.setBackgroundImage(disSelectedImg, for: .normal)
        
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        
        button.isUserInteractionEnabled = false
        
        print("button.isSelected: \(button.isSelected)")
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = button
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        if let button = self.accessoryView as? UIButton {
//            button.isSelected = !button.isSelected
//            print("222 button.isSelected: \(button.isSelected)")
//        }
//    }
    
    func updateContent(with item: ToDoItem) {
        self.textLabel?.text = item.name
        
        if let button = self.accessoryView as? UIButton {
            button.isSelected = item.isChecked
        }
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
