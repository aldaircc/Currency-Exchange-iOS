//
//  RestAPI.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation

enum responseAPI<T>{
    case failure(error: Error)
    case success(data: T)
}

protocol RestAPI {
    func callService<T:Decodable>(from url: String,
                                  verb: String,
                                  body: Data?,
                                  header: [String: Any]?,
                                  objectType: T.Type,
                                  completion: @escaping((responseAPI<T>)-> Void))
}

extension RestAPI{
    
    func callService<T:Decodable>(from url: String,
                                  verb: String,
                                  body: Data? = nil,
                                  header: [String: Any]? = nil,
                                  objectType: T.Type,
                                  completion: @escaping((responseAPI<T>)-> Void)){
        
        guard let serviceUrl = URL(string: url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = verb
        request.httpBody = body
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error: error))
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Json: \(json)")
                    
                    let decoder = JSONDecoder()
                    let decodeObject = try decoder.decode(objectType.self, from: data)
                    completion(.success(data: decodeObject))
                } catch (let exception) {
                    completion(.failure(error: exception))
                }
            }
            
        }.resume()
        
        
    }
}
