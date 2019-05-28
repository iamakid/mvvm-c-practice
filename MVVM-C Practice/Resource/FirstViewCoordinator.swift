//
//  FirstViewCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class FirstViewCoordinator: Coordinator<UINavigationController>, CoordinatingDependency {
    
    private(set) var viewController: FirstViewController!
    var dependency: AppDependency?
    
    override func start() {
        if (!started) {
            let vc = FirstViewController()
            vc.delegate = self
            viewController = vc
            show(viewController: vc)
        }
        super.start()
    }
}

extension FirstViewCoordinator: FirstViewControllerDelegate {
    func updateNum(in label: UILabel, newValue: Int) {
        label.text = "\(newValue)"
    }
}
