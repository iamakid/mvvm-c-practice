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
    
    func updateContent(with item: ToDoItem) {
        self.textLabel?.text = item.name
        
        if let button = self.accessoryView as? UIButton {
            button.isSelected = item.isChecked
        }
    }
}
