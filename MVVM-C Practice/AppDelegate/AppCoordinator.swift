//
//  AppCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator<UITabBarController> {
    
    private let dependency = AppDependency()
    
    override func start() {
        
        let rootTabBarCoordinator = RootTabBarCoordinator(viewController: rootViewController)
        rootTabBarCoordinator.dependency = self.dependency
        startChild(coordinator: rootTabBarCoordinator)
        super.start()
     
    }
}
