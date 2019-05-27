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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc1 = ViewController()
        vc1.view.backgroundColor = .red
        let vc2 = ViewController()
        vc2.view.backgroundColor = .yellow

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [vc1, vc2]
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController // appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate: UITabBarDelegate {
    
}
