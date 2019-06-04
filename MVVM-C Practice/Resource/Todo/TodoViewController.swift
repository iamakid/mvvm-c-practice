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
import SnapKit

class TodoViewController: UIViewController {
    
    let viewModel: TodoViewModel
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
    
    init(with viewModel: TodoViewModel ) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo"
        view.backgroundColor = .gray
        
        setupSubviews()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.inputs.fetchTodoItems()
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
        
        outputs.todoItems
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(
                cellIdentifier: "Cell",
                cellType: TodoTableViewCell.self)) { index, task, cell in
                    cell.updateContent(with: task)
            }
            .disposed(by: disposeBag)

        // UI binding
        addBarItem.rx.tap
            .subscribe { [weak self] _ in
                self?.showAddTodoAlert()
            }
            .disposed(by: disposeBag)
        
        // TableView Click Event
        tableView.rx
            .itemSelected
            .map{ $0.row }
            .subscribe(onNext: { index in
                inputs.selectTodoItem(at: index)
            })
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
            if let textField = alert.textFields?.first,
                let text = textField.text,
                text.count > 0 {
                self?.viewModel.inputs.addTodoItem(name: text)
            }
        }
        
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        
        present(alert, animated: true)
    }
}
