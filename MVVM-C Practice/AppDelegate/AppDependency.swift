//
//  AppDependency.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/27.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit

class KidData {
}

// 用來層層傳遞資訊給新的畫面
struct AppDependency {
    let todoManager = ToDoDataManager()
}

protocol CoordinatingDependency: class {
    
    // protocol內只能宣告var 
    var dependency: AppDependency? { set get }
}
