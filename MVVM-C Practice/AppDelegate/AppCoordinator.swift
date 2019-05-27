//
//  AppCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

// Kiddd
// 問題：為什麼要設T = UINavigationController
// 是因為RootTabBarCoordinator 之後的rootViewController要是UINavigationController，才在AppCoordinator的地方也設成UINavigationController嗎
class AppCoordinator: Coordinator<UINavigationController> {
    
    private let dependency = AppDependency()
    
    override func start() {
        
        let rootTabBarCoordinator = RootTabBarCoordinator(viewController: rootViewController)
        rootTabBarCoordinator.dependency = self.dependency
        startChild(coordinator: rootTabBarCoordinator)
        super.start()
     
    }
}
