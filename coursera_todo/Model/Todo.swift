//
//  Todo.swift
//  coursera_todo
//
//  Created by Muhammad Hashim on 1/24/20.
//  Copyright © 2020 Muhammad Hashim. All rights reserved.
//

import Foundation

struct Todos: Codable {
    let items: [Todo]
}

struct Todo: Codable {
    let item: String
    let priority: Int
}
