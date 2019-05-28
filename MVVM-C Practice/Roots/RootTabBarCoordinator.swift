//
//  RootTabBarCoordinator
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class RootTabBarCoordinator: Coordinator<UITabBarController>, CoordinatingDependency {

    // DelegateProxy
    private var tabBarDelegateProxy = TabBarDelegateProxy()
    private var navigationDelegateProxy = NavigationDelegateProxy()
    
    // Coordinator
    private var firstViewCoordinator: FirstViewCoordinator!
    private var secondViewCoordinator: SecondViewCoordinator!
    private var thirdViewCoordinator: ThirdViewCoordinator!
    private(set) var selectedCoordinator: Coordinating?
    
    // 有可能上一層的coordinator 沒有傳DI來，所以宣告為optional
    var dependency: AppDependency?
    
    override var childCoordinators: [Coordinating] {
        
        // 因為protocol 設定childCoordinators 為 var {get, setp}, 所以不能只實作getter。會變成get-only，不符合protocol
        set {}
        get {
            return [firstViewCoordinator, secondViewCoordinator, thirdViewCoordinator]
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
        
        let thirdBarNavigationController = generatedNavigationController(withTabBar: .bookmarks)
        thirdViewCoordinator = ThirdViewCoordinator(viewController: thirdBarNavigationController)
            
        rootViewController.delegate = tabBarDelegateProxy
        
        // 把Data傳下去給下一層的coordinator囉
        childCoordinators.forEach { coordinating in
            if let coordinatingDependency = coordinating as? CoordinatingDependency {
                coordinatingDependency.dependency = dependency
            }
        }
        
        rootViewController.viewControllers = [firstBarNavigationController, secondBarNavigationController, thirdViewCoordinator.rootViewController]
        selectedCoordinator = firstViewCoordinator

    }
    
    private final func generatedNavigationController( withTabBar systemItem: UITabBarItem.SystemItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: Int(arc4random()%10))
        
        // 如果沒有實作這一段，會導致parent coordinator一直持有所有的 children coodinator，children coordinator 都沒有被釋放
        // 做個實驗：當children coordinator持有一個vc & vm，而且parent coordinator沒有釋放children coordinator，那麼vc 就不會被呼叫到deinit()
        navigationController.interactivePopGestureRecognizer?.delegate = navigationDelegateProxy
        navigationController.delegate = navigationDelegateProxy
        return navigationController
    }
}

extension RootTabBarCoordinator: TabBarDelegateProxyDelegate {
    func tabBarDelegateProxy(_ proxy: TabBarDelegateProxy, didSelect viewController: UIViewController) {
        
        // coordinator呼叫的flow就是這樣
        // 雖然目前的deactive() 跟 active()還沒有實作，如果之後有特別需要實作的功能再implement
        selectedCoordinator?.deactive()
        let newSelectedCoordinator = childCoordinators[rootViewController.selectedIndex]
        newSelectedCoordinator.start()
        newSelectedCoordinator.active()
        selectedCoordinator = newSelectedCoordinator
    }
}
