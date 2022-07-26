//
//  PokemonTableViewCell.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let reuseID = "\(PokemonTableViewCell.self)"

    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBrown
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.borderColor = UIColor.systemGray2.cgColor
        imageView.layer.borderWidth = 7.0
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 30
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = "Name Of Pokemon"
        label.font = UIFont(name: "Georgia-Italic", size: 20)
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.systemGray2.cgColor
        label.layer.borderWidth = 2.3
        label.textAlignment = .center
        return label
    }()
    lazy var otherLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.text = "Element of Pokemon"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.systemGray2.cgColor
        label.layer.borderWidth = 2.3
        label.textAlignment = .center
        return label
    }()
//    lazy var backButton: UIButton = {
//        let button = UIButton(frame: .zero)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    var networkManager: NetworkManager?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.contentView.backgroundColor = .black
        
        self.contentView.addSubview(self.pokemonImageView)
        
        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        
        vStack.addArrangedSubview(self.titleLabel)
        vStack.addArrangedSubview(self.otherLabel)
//        vStack.addArrangedSubview(self.backButton)
        
        self.contentView.addSubview(vStack)
        
        self.pokemonImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.pokemonImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        self.pokemonImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        vStack.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 8).isActive = true
        vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -8).isActive = true
        vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -8).isActive = true
        
        vStack.leadingAnchor.constraint(equalTo: self.pokemonImageView.trailingAnchor,constant: 8).isActive = true
        
        self.pokemonImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }
//
    func configure(index: Int, pokemon: Pokemon, completion: @escaping (PokemonType) -> Void) {
        self.reset()
        var new = ""

        self.titleLabel.text = pokemon.name
        self.otherLabel.text = pokemon.url
        
        
        guard let url = URL(string:pokemon.url) else {
        return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse,!(200..<300).contains(httpResponse.statusCode) {
                print("Error Http response error")
                return
                
            }
            guard let data = data else {
                print("error with data")
                return
            }
            
            do {
                let pageResult = try JSONDecoder().decode(PokemonType.self, from: data)
                for i in 0..<pageResult.types.count{
                
                if new == "" {
                    new = pageResult.types[i].type.name + "\n"
                }
                else {
                    new += pageResult.types[i].type.name + "\n"
                }
                }
                self.networkManager?.fetchImageData(imagePath:pageResult.sprites.front_default!){ results in
                    switch results {
                    case .success(let picture):
                        
                        DispatchQueue.main.async {
                            self.otherLabel.text = new
                            self.pokemonImageView.image = UIImage(data:picture)
                    }
                    ImageCache.shared.setImageData(key: pageResult.sprites.front_default!, data: picture)
                    completion(pageResult)
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
                    }
                    
                }
                
            } catch {
                print("Error with model")
            }
                
            
        }
        task.resume()
        }

    private func reset() {
        self.pokemonImageView.image = UIImage(named: "2chainz")
        self.titleLabel.text = "Name Of Pokemon"
        self.otherLabel.text = "Element of Pokemon"
        
    }
}



