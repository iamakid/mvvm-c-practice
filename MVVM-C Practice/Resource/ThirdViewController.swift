//
//  ThirdViewController.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

protocol ThirdViewControllerDelegate {
    func presentNewViewController(_ viewController: UIViewController)
}

class ThirdViewController: UIViewController {

    var delegate: ThirdViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        title = "ThirdViewController"
        view.backgroundColor = .green
        
        let button = UIButton(type: .system)
        button.setTitle("click me" + "_\(arc4random() % 1000)", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
    }

    @objc func buttonClicked(_ sender: UIButton) {
        delegate?.presentNewViewController(self)
    }
}

