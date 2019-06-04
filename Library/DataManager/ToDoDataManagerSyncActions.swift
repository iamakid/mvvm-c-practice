//
//  ToDoDataManagerSyncActions.swift
//  CoodinatorPractice
//
//  Created by GreenChiu on 2019/2/18.
//  Copyright © 2019 Green. All rights reserved.
//

import Foundation

protocol ToDoDataManagerSyncActions: class {
    func retriveToDoItems( finishCallback callback: @escaping ([ToDoItem]?, Error?) -> Void)
    func synchornized(_ todos:[ToDoItem], finishCallback callback: @escaping (Error?) -> Void) -> Void
}
