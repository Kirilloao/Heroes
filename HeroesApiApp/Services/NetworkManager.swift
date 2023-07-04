//
//  NetworkManager.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 04.07.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // fetchHeroes
    func fetchHeroes(from url: String, completion: @escaping(Result<[Hero], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data )
                
                DispatchQueue.main.async {
                    completion(.success(heroes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    // fetchImage
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

// MARK: - Links
enum Links: String {
    case heroesApi = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.2.0/api/all.json"
}
