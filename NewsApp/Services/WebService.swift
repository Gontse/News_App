//
//  webServices.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/05.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

struct Resource<T:Codable> {
    let  url: URL
}


class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else{
                completion(.failure(.domainError))
                return
            }
            //Make it optional lest the decode fail
            let results = try? JSONDecoder().decode(T.self, from: data)
            if let results = results {
                 //Data will be passed to the UI use main thread.
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            }else{
                //Failed to decode the object
                completion(.failure(.decodingError))
            }
            
            
        }.resume()
        
    }
    
}
