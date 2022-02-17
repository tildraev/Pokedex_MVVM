//
//  PokemonViewController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: AsyncImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    var viewModel: PokemonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.delegate = self
        pokemonMovesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
} // end

extension PokemonViewController: PokemonViewModelDelegate {
    
    func updateViews() {
        guard let pokemon = viewModel.pokemon else {return}
        
        self.pokemonNameLabel.text = pokemon.name.capitalized
        self.pokemonIDLabel.text = "No: \(pokemon.id)"
        self.pokemonMovesTableView.reloadData()
        
        guard let url = URL(string: pokemon.sprites.frontShiny) else { return }
        let urlRequest = URLRequest(url: url)
        pokemonSpriteImageView.setImage(using: urlRequest)
    }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Moves"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemon?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        guard let pokemon = viewModel.pokemon else {return UITableViewCell() }
        let move = pokemon.moves[indexPath.row].move.name
        cell.textLabel?.text = move
        return cell
    }
} // end
