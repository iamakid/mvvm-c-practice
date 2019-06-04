//
//  ToDoViewController.swift
//  MVVM-C Practice
//
//  Created by Kid Tsui on 2019/5/31.
//  Copyright © 2019 Kid Tsui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//import RxDataSources
import SnapKit

protocol TodoViewModelInputs {
    
    var addTodoAction: PublishSubject<String> { get }
    var selectedTodoAction: PublishSubject<Int> { get }
}

protocol TodoViewModelOutputs {
    var fetchTasks: Observable<[ToDoItem]> { get }
}

protocol TodoViewModelType {
    var inputs: TodoViewModelInputs { get }
    var outputs: TodoViewModelOutputs { get }
}

class TodoViewModel: TodoViewModelType, TodoViewModelInputs {
    
    var inputs: TodoViewModelInputs { return self }
    var outputs: TodoViewModelOutputs { return self }
    
    let addTodoAction = PublishSubject<String>()
    let selectedTodoAction = PublishSubject<Int>()
    let disposeBag = DisposeBag()
    
    private let taskItems = BehaviorRelay<[ToDoItem]>(value: [])
    
    init() {
        bind()
    }
}

extension TodoViewModel {
    
    func bind() {
        
        addTodoAction
            .subscribe(onNext: {  [unowned self] taskName in
                print("addTodoAction: \(taskName)")
                
                let item = ToDoItem(name: taskName, isChecked: false)
                self.taskItems.accept(self.taskItems.value + [item])
            })
            .disposed(by: disposeBag)
        
        selectedTodoAction
            .subscribe(onNext: { index in
                print("selectedTodoAction: at \(index)")
                var currentItems = self.taskItems.value
                
                var task = self.taskItems.value[index]
                task.isChecked = !task.isChecked
                
                currentItems[index] = task
                
                self.taskItems.accept(currentItems)
            })
            .disposed(by: disposeBag)
    }
}

extension TodoViewModel: TodoViewModelOutputs {
    var fetchTasks: Observable<[ToDoItem]> {
        return taskItems.asObservable()
    }
}

class TodoViewController: UIViewController {
    
    let viewModel = TodoViewModel()
    let disposeBag = DisposeBag()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.select
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    // By Kyle
    // 此時的target 跟 action 還沒有在virtual table中被建立
    let addBarItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo"
        view.backgroundColor = .gray
        
        setupSubviews()
        bind()
    }
    
    func setupSubviews() {
        
        navigationItem.rightBarButtonItem = addBarItem

        // Add Todo tableview
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func bind() {
        
        let outputs = viewModel.outputs
        let inputs = viewModel.inputs

        outputs.fetchTasks.subscribe {
            print($0)
        }.disposed(by: disposeBag)
        
        
        outputs.fetchTasks
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(
                cellIdentifier: "Cell",
                cellType: TodoTableViewCell.self)) { index, task, cell in
//                    cell.textLabel?.text = task.name
                    cell.updateContent(with: task)
            }
            .disposed(by: disposeBag)

        // ui binding
        addBarItem.rx.tap
            .subscribe { [weak self] _ in
                self?.showAddTodoAlert()
            }
            .disposed(by: disposeBag)
        
        // TableView Click Event
        tableView.rx
            .itemSelected
            .map{ $0.row }
            .bind(to: inputs.selectedTodoAction)
            .disposed(by: disposeBag)
        
//        tableView.rx
//            .modelSelected(String.self)
//            .subscribe(onNext: { model in
//                print("\(model) was selected")
//            })
//            .disposed(by: disposeBag)
    }
}

extension TodoViewController {
    func showAddTodoAlert() {
        
        let alert = UIAlertController(title: "task name", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let cancelBtn = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okBtn = UIAlertAction(title: "ok", style: .default) { [weak self] _ in
            if
                let textField = alert.textFields?.first,
                let text = textField.text,
                text.count > 0 {
                print(text)
                
                self?.viewModel.inputs.addTodoAction.onNext(text)
            }
        }
        
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        
        present(alert, animated: true)
    }
}
