//
//  TodoCoordinator.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/31.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class TodoCoordinator: Coordinator<UINavigationController>, CoordinatingDependency {
    var dependency: AppDependency?
    
    override func start() {
        if (!started) {
            let viewModel = TodoViewModel(with: dependency!.todoManager)
            let vc = TodoViewController(with: viewModel)
//            vc.delegate = self
//            viewController = vc
            show(viewController: vc)
        }
        super.start()
    }
}
