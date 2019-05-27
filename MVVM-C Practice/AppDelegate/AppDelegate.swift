//
//  AppDelegate.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private(set) var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Kid:
        // 為什麼window.rootViewController 是UINavigationController 而不是 UITabBarViewController
        // 為什麼要到 AppCoodinator.start() 裡面才去設定 UITabBarViewController 的coordinator
        appCoordinator = AppCoordinator(viewController: UINavigationController())

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()

        appCoordinator.start()
        
//
//        let vc1 = FirstViewController()
//        vc1.view.backgroundColor = .red
//        let vc2 = SecondViewController()
//        vc2.view.backgroundColor = .yellow
//
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [vc1, vc2]
//        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = tabBarController // appCoordinator.rootViewController
//        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate: UITabBarDelegate {
    
}
