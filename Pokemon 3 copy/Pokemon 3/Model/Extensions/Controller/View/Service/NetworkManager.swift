//
//  NetworkManager.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

import Foundation

class NetworkManager {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
extension NetworkManager {
    
    func fetchPokemon(page: Int, completion: @escaping (Result<PageResult, Error>) -> Void) {
    
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=30\(page)")
                        else {
        completion(.failure(NetworkError.badURL))
        return
    }
    self.session.dataTask(with: url) { data, response, error in
        
        if let error = error {
            completion(.failure(error))
            return
        }
        if let httpResponse = response as? HTTPURLResponse,!(200..<300).contains(httpResponse.statusCode) {
            completion(.failure(NetworkError.badServiceResponse(httpResponse.statusCode)))
            return
            
        }
        guard let data = data else {
            completion(.failure(NetworkError.badData))
            return
        }
        do {
            let pageResult = try JSONDecoder().decode(PageResult.self, from: data)
            completion(.success(pageResult))
            
        } catch {
            completion(.failure(NetworkError.decodeError("\(error)")))
        }
            
        
    }.resume()
}
    //
    func fetchImageData(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string:imagePath) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServiceResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            completion(.success(data))
            
        }.resume()
        
    }
    
    
}
