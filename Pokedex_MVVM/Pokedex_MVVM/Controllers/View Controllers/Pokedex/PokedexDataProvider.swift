//
//  DataProvider.swift
//  Pokedex_MVVM
//
//  Created by Arian Mohajer on 2/16/22.
//

import Foundation

struct PokedexDataProvider: APIDataProvidable {
    func fetchPokedex(from url: URL, completion: @escaping (Result<Pokedex, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: url)
        
        perform(urlRequest) { result in
            switch result {
            
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(Pokedex.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.errorDecoding))
                }
                
            case .failure(let error):
                completion(.failure(.errorDecoding))
                print(error)
            }
        }
    }
}

extension URL {
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
}
