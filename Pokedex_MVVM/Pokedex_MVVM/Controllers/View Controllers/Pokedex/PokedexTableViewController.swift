//
//  PokedexTableViewController.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 2/16/22.
//

import UIKit



class PokedexTableViewController: UITableViewController, PokedexViewModelDelegate {
    
    var pokedex: Pokedex?
    var pokedexResults: [PokemonResults] = []
    
    var viewModel: PokedexViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PokedexViewModel(delegate: self)
        guard let url = URL.baseURL else { return }
        viewModel.fetchPokedex(url: url)
    }
    
    func resultsReceived() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pokedexResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        let pokemon = viewModel.pokedexResults[indexPath.row].url
        let viewModel = PokemonViewModel(delegate: cell, pokemonURL: pokemon)
        cell.viewModel = viewModel
        return cell
    }
    
    //MARK: - Pagination
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastPokedexIndex = viewModel.pokedexResults.count - 1
        guard let pokedex = viewModel.pokedex, let nextURL = URL(string: pokedex.next) else {return}
        if indexPath.row == lastPokedexIndex {
            viewModel.fetchPokedex(url: nextURL)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPokemonDetails",
           let destinationVC = segue.destination as? PokemonViewController {
            guard let sender = sender as? PokemonTableViewCell else { return }
            destinationVC.viewModel = sender.viewModel
        }
    }
}
