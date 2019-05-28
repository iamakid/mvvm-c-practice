//
//  PresentViewController.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/28.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class PresentedCoordinator: Coordinator<UIViewController>, CoordinatingDependency {
    var dependency: AppDependency?

    override func start() {
        
        let vc = PresentedViewController()
        vc.view.backgroundColor = .brown
        
        vc.delegate = self
        present(viewController: vc)
        super.start()
    }
}

extension PresentedCoordinator: PresentedViewControllerDelegate {
    func dismiss(presentedViewController: PresentedViewController) {
        rootViewController.dismiss(animated: true, completion: {
            
            // 記得要在dismiss後手動把child coordinator給stop
            self.parent?.stopChild(coordinator: self)
        })
    }
}

