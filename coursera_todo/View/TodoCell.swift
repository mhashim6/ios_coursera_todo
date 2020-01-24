//
//  TodoCell.swift
//  coursera_todo
//
//  Created by Muhammad Hashim on 1/24/20.
//  Copyright © 2020 Muhammad Hashim. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoPriority: UIView!

    func updateData(todo: Todo){
        todoLabel.text = todo.item
        todoPriority.layer.cornerRadius = 20
        switch todo.priority {
        case 0:
            todoPriority.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case 1:
            todoPriority.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 2:
            todoPriority.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        default: break
        }
    }
    

}

