//
//  NetworkingController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import Foundation
import UIKit.UIImage

class NetworkingController {
    
    private static let baseURLString = "https://pokeapi.co"
    
    static var initalURL: URL? {
        guard let baseURL = URL(string: baseURLString) else {return nil}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/api/v2/pokemon"
        
        guard let initalURL = urlComponents?.url else {return nil}
        print(initalURL)
        return initalURL
    }
    
    static func fetchPokedex(with url: URL, completion: @escaping(Result<Pokedex, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { dTaskData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            
            guard let pokemonData = dTaskData else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            
            do {
                let pokedex =  try JSONDecoder().decode(Pokedex.self, from: pokemonData)
                completion(.success(pokedex))
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(.failure(.errorDecoding))
            }
        }.resume()
    }
    
    static func fetchPokemon(with urlString: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let pokemonURL = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: pokemonURL) { dTaskData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            
            guard let pokemonData = dTaskData else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            
            do {
                let pokemon =  try JSONDecoder().decode(Pokemon.self, from: pokemonData)
                completion(.success(pokemon))
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(.failure(.errorDecoding))
            }
        }.resume()
    }
    
    static func fetchImage(for pokemonImagePath: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: pokemonImagePath) else {return}
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            guard let data = data else {
                    completion(.failure(.couldNotUnwrap))
                return
            }
            guard let pokemonImage = UIImage(data: data) else {
                completion(.failure(.errorDecoding))
                return
            }
            completion(.success(pokemonImage))
        }.resume()
    }
}// end
