//
//  PokemonDataProvider.swift
//  Pokedex_MVVM
//
//  Created by Arian Mohajer on 2/16/22.
//

import Foundation

struct PokemonDataProvider: APIDataProvidable {
    
    
    func fetchPokemon(from url: URL, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: url)
        
        perform(urlRequest) { result in
            switch result {
                
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    
                }
            case .failure(let error):
                print(error)
                completion(.failure(.badURL))
            }
        }
    }
}
