//
//  PresentedViewController.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/28.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

protocol PresentedViewControllerDelegate: class {
    func dismiss(presentedViewController: PresentedViewController)
}

class PresentedViewController: UIViewController {
    weak var delegate: PresentedViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("dismiss VC", for: .normal)
        button.addTarget(self, action: #selector(dismissPresentedVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc private func dismissPresentedVC() {
        delegate?.dismiss(presentedViewController: self)
    }
    
}
