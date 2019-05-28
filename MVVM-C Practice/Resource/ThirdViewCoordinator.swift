//
//  ThirdViewCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class ThirdViewCoordinator: Coordinator<UINavigationController>, CoordinatingDependency {
    
    var dependency: AppDependency?
    let vc = ThirdViewController()
    
    override func start() {
        if (!started) {
            
            vc.delegate = self
            show(viewController: vc, animated: false)
        }
        super.start()
    }
}

extension ThirdViewCoordinator: ThirdViewControllerDelegate {
    func presentNewViewController(_ viewController: UIViewController) {
        
        let coordinator = PresentedCoordinator(viewController: vc)
        startChild(coordinator: coordinator)
    }
}
