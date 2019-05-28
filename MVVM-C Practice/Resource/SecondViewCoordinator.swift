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
        
        // Q: 為什麼要把rootViewController 傳到下一層coordinator當 rootViewController
        // A: 之後的UINavigationController 還是要用最原始的 navigationController，
        // 而這個navigationController 也是層層從前一個coordinator傳進來的
        let coordinator = SecondViewCoordinator(viewController: rootViewController)
        startChild(coordinator: coordinator)
    }
}
