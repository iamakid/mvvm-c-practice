//
//  RootTabBarCoordinator
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class RootTabBarCoordinator: Coordinator<UITabBarController>, CoordinatingDependency {

    private var tabBarDelegateProxy = TabBarDelegateProxy()
    private var navigationDelegateProxy = NavigationDelegateProxy()
    private var firstViewCoordinator: FirstViewCoordinator!
    private var secondViewCoordinator: SecondViewCoordinator!
    private(set) var selectedCoordinator: Coordinating?
    
    var dependency: AppDependency?
    
    override var childCoordinators: [Coordinating] {
        // Kiddd
        // 因為protocol 設定childCoordinators為var, 所以不能只實作getter。會變成get-only，不符合protocol
        set {}
        get {
            return [firstViewCoordinator, secondViewCoordinator]
        }
    }
    
    override func start() {
        constructChildCoordinatorsIfNeed()
        selectedCoordinator?.start()
        super.start()
    }
}

extension RootTabBarCoordinator {
    private final func constructChildCoordinatorsIfNeed() {
        if started {
            return
        }
        
        tabBarDelegateProxy.delegate = self
        
        let firstBarNavigationController = generatedNavigationController(withTabBar: .featured)
        firstViewCoordinator = FirstViewCoordinator(viewController: firstBarNavigationController)
        
        let secondBarNavigationController = generatedNavigationController(withTabBar: .history)
        secondViewCoordinator = SecondViewCoordinator(viewController: secondBarNavigationController)
        
        rootViewController.delegate = tabBarDelegateProxy
        
        childCoordinators.forEach { coordinating in
            if let coordinatingDependency = coordinating as? CoordinatingDependency {
                coordinatingDependency.dependency = dependency
            }
        }
        
        rootViewController.viewControllers = [firstBarNavigationController, secondBarNavigationController]
        selectedCoordinator = firstViewCoordinator

    }
    
    private final func generatedNavigationController( withTabBar systemItem: UITabBarItem.SystemItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: Int(arc4random()%10))
        
        // Kiddd
        // 如果沒有實作這一段，會導致parent coordinator一直持有所有的 children coodinator，children coordinator 都沒有被釋放
        // 做個實驗：當children coordinator持有一個vc & vm，而且parent coordinator沒有釋放children coordinator，那麼vc 就不會被呼叫到deinit()
        navigationController.interactivePopGestureRecognizer?.delegate = navigationDelegateProxy
        navigationController.delegate = navigationDelegateProxy
        return navigationController
    }
    
}

extension RootTabBarCoordinator: TabBarDelegateProxyDelegate {
    func tabBarDelegateProxy(_ proxy: TabBarDelegateProxy, didSelect viewController: UIViewController) {
        selectedCoordinator?.deactive()
        let newSelectedCoordinator = childCoordinators[rootViewController.selectedIndex]
        newSelectedCoordinator.start()
        newSelectedCoordinator.active()
        selectedCoordinator = newSelectedCoordinator
    }
}
