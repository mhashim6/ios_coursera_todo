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
    
    private let URL_BASE = "http://192.168.1.10:3003"
    private let URL_ADD = "/add"
    
    func getTodos(_ onSuccess: @escaping ([Todo]) -> Void, _ onError: @escaping (String) -> Void){
        let url = URL(string: URL_BASE)!
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    onError("error: \(error!.localizedDescription)")
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else{
                    onError("Data corruption!")
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
    
    func addTodo(todo: Todo, _ onSuccess: @escaping ([Todo]) -> Void, _ onError: @escaping (String) -> Void){
        let url = URL(string: "\(URL_BASE)\(URL_ADD)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body
        } catch {
            debugPrint(error)
        }
        
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            DispatchQueue.main.async {
                
                do{
                    if (response as! HTTPURLResponse).statusCode == 200{
                        let todos = try JSONDecoder().decode(Todos.self, from: data!)
                        onSuccess(todos.items)
                    } else{
                        let err = try JSONDecoder().decode(APIError.self, from: data!)
                        onError("error: \(err)")
                    }
                } catch{
                    debugPrint("erroraasfasfasf: \(error)")
                }
            }
        }
        task.resume()
    }
}
