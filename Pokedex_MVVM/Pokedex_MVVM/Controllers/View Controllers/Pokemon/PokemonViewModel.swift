//
//  PokemonViewModel.swift
//  Pokedex_MVVM
//
//  Created by Arian Mohajer on 2/16/22.
//

import Foundation

protocol PokemonViewModelDelegate: AnyObject {
    func updateViews()
}

class PokemonViewModel {
    weak var delegate: PokemonViewModelDelegate?
    let dataProvider = PokemonDataProvider()
    
    init(delegate: PokemonViewModelDelegate, pokemonURL: String) {
        self.delegate = delegate
        fetchPokemon(url: pokemonURL)
    }
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateViews()                
            }
        }
    }
    
    func fetchPokemon(url: String) {
        guard let url = URL(string: url) else { return }
        dataProvider.fetchPokemon(from: url) { result in
            switch result {
                
            case .success(let pokemon):
                self.pokemon = pokemon
            case .failure(let error):
                print(error)
            }
        }
    }
}
