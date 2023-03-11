//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit
import ZoogleAnalytics

class PokemonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    private var viewModel: PokemonListViewModel!

    private let loadingReuseIdentifier = "loading"
    private let pokemonItemReuseIdentifier = "pokemon"

    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon"
        self.viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: loadingReuseIdentifier)
        tableView.register(UINib(nibName: "PokemonListItemTableViewCell", bundle: nil), forCellReuseIdentifier: pokemonItemReuseIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = viewModel.pokemon.count
        if viewModel.morePokemonToLoad {
            rowCount += 1
        }
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        if indexPath.row >= viewModel.pokemon.count {
            cell = tableView.dequeueReusableCell(withIdentifier: loadingReuseIdentifier)
            viewModel.fetchMorePokemon()
        } else if let pokemonCell = tableView.dequeueReusableCell(withIdentifier: pokemonItemReuseIdentifier) as? PokemonListItemTableViewCell {
            pokemonCell.titleLabel.text = viewModel.pokemon[indexPath.row].name.capitalized
            cell = pokemonCell
        }

        guard let cell = cell else {
            fatalError("Could not find a cell")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.pokemon.count else {
            return
        }

        guard let pokemonId = viewModel.pokemon[indexPath.row].id else {
            pokemonIdNotFound()
            return
        }

        ZoogleAnalytics.shared.log(event: ZoogleAnalyticsEvent(key: "pokemon_selected", parameters: ["id": pokemonId]))

        let viewModel = PokemonDetailsViewModel(id: pokemonId)
        navigationController?.show(PokemonDetailsViewController(viewModel: viewModel), sender: self)
    }

    private func pokemonIdNotFound() {
        let alert = UIAlertController(title: nil,
            message: "We could not open details of this Pokemon, please try again later.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion:nil)
    }

}

extension PokemonListViewController: PokemonListDelegate {
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    func showErrorMessage(title: String?, message: String) {
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion:nil)
    }
}
