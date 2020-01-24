//
//  ViewController.swift
//  coursera_todo
//
//  Created by Muhammad Hashim on 1/24/20.
//  Copyright © 2020 Muhammad Hashim. All rights reserved.
//

import UIKit

class TodoVC: UIViewController {
    
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todosTable: UITableView!
    
    private var todos = [Todo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.getTodos{items in
            self.todos = items
            self.todosTable.reloadData()
        }
        todosTable.delegate = self
        todosTable.dataSource = self
    }
    
    
    @IBAction func addTodo(_ sender: Any) {
    }
}
extension TodoVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let todoCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell else {
            return TodoCell()
        }
        todoCell.updateData(todo: todos[indexPath.row])
        return todoCell
    }
    
    
}
