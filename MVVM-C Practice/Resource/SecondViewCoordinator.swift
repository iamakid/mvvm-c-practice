//
//  SecondViewCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class SecondViewCoordinator: Coordinator<UINavigationController>, CoordinatingDependency {
    
    private(set) var viewController: SecondViewController!
    var dependency: AppDependency?
    
    override func start() {
        if (!started) {
            let vc = SecondViewController()
            vc.delegate = self
            viewController = vc
            show(viewController: vc)
        }
        super.start()
    }
}

extension SecondViewCoordinator: SecondViewControllerDelegate {
    func shouldPushNewViewController() {
        
        let coordinator = SecondViewCoordinator(viewController: rootViewController)
        startChild(coordinator: coordinator)
    }
}
