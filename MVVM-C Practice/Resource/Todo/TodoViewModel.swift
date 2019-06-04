//
//  TodoViewModel.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/6/4.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let kTodoListKey = "TodoList"

protocol TodoViewModelInputs {
    
    // kiddd
    // inputs 都是func, 不要讓外部可以去修改裡面的值
    // outputs 都是observable { get }
    func fetchTodoItems()
    func saveTodoItems()
    func addTodoItem(name: String)
    func selectTodoItem(at index:Int)
}

protocol TodoViewModelOutputs {
    var todoItems: Observable<[ToDoItem]> { get }
}

protocol TodoViewModelType {
    var inputs: TodoViewModelInputs { get }
    var outputs: TodoViewModelOutputs { get }
}

class TodoViewModel: TodoViewModelType {
    
    private let kidTodoItems = BehaviorRelay<[ToDoItem]>(value: [])
    private let refreshTrigger = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    
    let todoManager: ToDoDataManager
    
    var inputs: TodoViewModelInputs { return self }
    var outputs: TodoViewModelOutputs { return self }
    
    init(with todoManager: ToDoDataManager) {
        self.todoManager = todoManager
        bind()
    }
    
    func bind() {
    }
}

extension TodoViewModel: TodoViewModelInputs {
    
    func addTodoItem(name: String) {
        let item = ToDoItem(name: name, isChecked: false)
        kidTodoItems.accept(kidTodoItems.value + [item])
        
        todoManager.synchornized(self.kidTodoItems.value, finishCallback: {_ in
            print("saved")
        })
    }
    
    func selectTodoItem(at index:Int) {
        var oldItems = kidTodoItems.value
        var item = oldItems[index]
        item.isChecked = true
        oldItems[index] = item
        
        kidTodoItems.accept(oldItems)
    }
    
    // todo
    func fetchTodoItems() {

    }
    
    func saveTodoItems() {
        print("saveTodoItems")
    }
}
extension TodoViewModel: TodoViewModelOutputs {
    var todoItems: Observable<[ToDoItem]> {
        return kidTodoItems.asObservable()
    }
}
