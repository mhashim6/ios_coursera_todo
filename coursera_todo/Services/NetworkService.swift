//
//  NetworkService.swift
//  coursera_todo
//
//  Created by Muhammad Hashim on 1/24/20.
//  Copyright © 2020 Muhammad Hashim. All rights reserved.
//

import Foundation


//My God! this code is terrifying!

class NetworkService{
    static let shared = NetworkService()
    
    private let URL_BASE = "http://192.168.1.10:3003/"
    private let URL_ADD = "/add"
    
    func getTodos(onSuccess: @escaping ([Todo]) -> Void){
        let url = URL(string: URL_BASE)!
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    debugPrint("error: \(error!.localizedDescription)")
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else{
                    debugPrint("Data corruption!")
                    return
                }
                do {
                    if response.statusCode == 200{
                        let todos = try JSONDecoder().decode(Todos.self, from: data)
                        onSuccess(todos.items)
                    } else{
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        debugPrint("error: \(err)")
                    }
                } catch  {
                    debugPrint("error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func addTodo(todo: Todo){
        
    }
}
