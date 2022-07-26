//
//  PokemonViewController.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    lazy var pokemonTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.prefetchDataSource = self
        tableview.backgroundColor = .black
        tableview.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseID)
        return tableview
    }()
    
    var Pokemon: [Pokemon] = []
    var pokemon_details: [Int:PokemonType] = [:]
    var nextPage = 0
    let networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.fetchPage()
    }
        private func setUpUI(){
            self.view.backgroundColor = .systemBrown
            self.view.addSubview(self.pokemonTableView)
            
            self.pokemonTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
            self.pokemonTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
            self.pokemonTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
            self.pokemonTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:
                                                            -15).isActive = true
}
        func fetchPage() {
            self.networkManager.fetchPokemon(page: self.nextPage) { result in
                switch result {
                case .success(let page):
                    self.Pokemon.append(contentsOf: page.results)
                    self.nextPage += 1
                    DispatchQueue.main.async {
                        self.pokemonTableView.reloadData()
                }
            case .failure(let err):
                print("Error: \(err.localizedDescription)")
                    self.presentErrorAlert(title: "NetworkError", message:
                                            err.localizedDescription)
                }
            }
        }
}
extension PokemonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pokemon.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseID, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        if cell.networkManager == nil {
            cell.networkManager = self.networkManager
        }
        cell.configure(index: indexPath.row, pokemon: self.Pokemon[indexPath.row]){
            results in
            if self.pokemon_details[indexPath.row] == nil {
                self.pokemon_details[indexPath.row] = results
            }
            
        }
        return cell
    }
    }


extension PokemonViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.Pokemon.count - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return
            if (self.nextPage < 150){
                self.nextPage += 30
                self.fetchPage()
            }
        }
//        self.fetchPage()
    }
    
    
}
extension UIViewController {
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let VCDetail = DetailVCOne()
        let pokemonName = self.Pokemon[indexPath.row].name
        let moreInfo = self.Pokemon[indexPath.row].url
        VCDetail.pokemonName = pokemonName
        VCDetail.moreInfo = moreInfo
        VCDetail.pokemon_atrr = self.pokemon_details[indexPath.row]
        
        self.present(VCDetail, animated: true)
    }
}

