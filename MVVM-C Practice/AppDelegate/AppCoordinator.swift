//
//  AppCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

// RootViewController可以視為目前頁面主要用來導頁的機制
// 如果是用UINavigationController 做push的話，這裏就改成 <UINavigationController>

class AppCoordinator: Coordinator<UITabBarController> {
    
    private let dependency = AppDependency()
    
    override func start() {
        
        let rootTabBarCoordinator = RootTabBarCoordinator(viewController: rootViewController)
        
        // 設定要傳下去的DI (data, manager, any objects...)
        // 在coordinator的世界是層層傳遞的，即使是到第5層vc / coordinator才會用到，還是會一路傳下去
        rootTabBarCoordinator.dependency = self.dependency
        
        // 導頁的時候就是呼叫 startChild(coordinator:)
        startChild(coordinator: rootTabBarCoordinator)
        super.start()
     
    }
}
