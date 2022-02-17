//
//  PokemonTableViewCell.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell, PokemonViewModelDelegate {
    
    @IBOutlet weak var pokemonImageView: AsyncImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    var viewModel: PokemonViewModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
    }
    
    func updateViews() {        
        guard let pokemon = viewModel.pokemon else { return }
        self.pokemonNameLabel.text = pokemon.name.capitalized
        self.pokemonIDLabel.text = "No: \(pokemon.id)"
    
        guard let url = URL(string: pokemon.sprites.frontShiny) else { return }
        let urlRequest = URLRequest(url: url)
        pokemonImageView.setImage(using: urlRequest)
    }
}
