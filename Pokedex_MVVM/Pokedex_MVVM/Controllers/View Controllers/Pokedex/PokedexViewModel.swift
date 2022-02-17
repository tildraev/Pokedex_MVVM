//
//  PokedexViewModel.swift
//  Pokedex_MVVM
//
//  Created by Arian Mohajer on 2/16/22.
//

import Foundation

protocol PokedexViewModelDelegate: AnyObject {
    func resultsReceived()
}

class PokedexViewModel{
    
    var pokedex: Pokedex?
    var pokedexResults: [PokemonResults] = []
    var dataProvider: PokedexDataProvider
    var pokemonDataProvider: PokemonDataProvider
    
    weak var delegate: PokedexViewModelDelegate?
    
    init(dataProvider: PokedexDataProvider = PokedexDataProvider(), pokemonDataProvider: PokemonDataProvider = PokemonDataProvider(), delegate: PokedexViewModelDelegate) {
        self.delegate = delegate
        self.dataProvider = dataProvider
        self.pokemonDataProvider = pokemonDataProvider
    }
    
    func fetchPokedex(url: URL) {
        dataProvider.fetchPokedex(from: url) { [weak self] result in
            switch result {
                
            case .success(let pokedex):
                self?.pokedex = pokedex
                self?.pokedexResults.append(contentsOf: pokedex.results)
                self?.delegate?.resultsReceived()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

