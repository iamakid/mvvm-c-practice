//
//  AppDelegate.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

// Kiddd
// 概念 Coordinator只做導頁，裡面只會導頁到一個指定的 UIViewController
// ex: ACoordinator 裡面的vc只會有 AViewController (和AViewControllerDelegate)
//     BCoordinator 裡面的vc只會有 BViewController (和BViewControllerDelegate)
// 所以 CCoordinator 呼叫 ACoordinator 的時候，永遠只會導頁到 AViewController～

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private(set) var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 整個App的 rootViewController 由 AppCoordinator 來設定
        // 這個範例的階層關係是 App -> UITabBarController -> [FirstViewController, SecondeViewController]
        
        appCoordinator = AppCoordinator(viewController: UITabBarController())

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()

        appCoordinator.start()
        
        return true
    }
}

extension AppDelegate: UITabBarDelegate {
    
}
