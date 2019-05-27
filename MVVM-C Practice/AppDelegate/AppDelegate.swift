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
