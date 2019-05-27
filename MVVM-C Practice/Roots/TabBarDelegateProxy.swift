//
//  TabBarDelegateProxy.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

protocol TabBarDelegateProxyDelegate : class {
    func tabBarDelegateProxy( _ proxy: TabBarDelegateProxy, didSelect viewController: UIViewController) -> Void
}

class TabBarDelegateProxy: NSObject, UITabBarControllerDelegate {
    
    weak var delegate: TabBarDelegateProxyDelegate?
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        delegate?.tabBarDelegateProxy(self, didSelect: viewController)
    }
}
