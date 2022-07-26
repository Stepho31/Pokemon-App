////
////  DetailVCOne.swift
////  Pokemon 3
////
////  Created by Consultant on 5/9/22.
////
//
//
import Foundation
import UIKit

class DetailVCOne: UIViewController {
    var pokemonName: String?
    var moreInfo = String()
    var diffInfo = String()
    var pokemon_atrr: PokemonType?
    var abilitiesOfPokemon = ""
    var pokemon_moves: PokemonType?
    var movesOfPokemon = ""
    
    let abilityLabel: UILabel = {
        let Label = UILabel(frame: .zero)
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.text = "Ability: "
        Label.font = UIFont(name: "Georgia-Italic", size: 25.0)
        Label.textColor = .black
        Label.backgroundColor = .white
        Label.layer.masksToBounds = true
        Label.layer.cornerRadius = 5
        Label.numberOfLines = 0
        Label.layer.borderColor = UIColor.systemCyan.cgColor
        Label.layer.borderWidth = 1
        Label.textAlignment = .center
        Label .sizeToFit()
        return Label
    }()
    
    let moveLabel: UILabel = {
        let LabelMove = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        LabelMove.translatesAutoresizingMaskIntoConstraints = false
        LabelMove.text = "Moves: "
        LabelMove.font = UIFont(name: "Helvetica-Bold", size: 25.0)
        LabelMove.textColor = .black
        LabelMove.backgroundColor = .white
        LabelMove.layer.masksToBounds = true
        LabelMove.layer.cornerRadius = 10
        LabelMove.numberOfLines = 0
        LabelMove.textAlignment = .center
        LabelMove .sizeToFit()
        return LabelMove
    }()

    let nameLabel: UILabel = {
        var nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 35.0)
        nameLabel.textColor = .black
        nameLabel.backgroundColor = .white
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 5
        nameLabel.numberOfLines = 0
        nameLabel.layer.borderColor = UIColor.systemGray2.cgColor
        nameLabel.layer.borderWidth = 2
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    let myImageView:UIImageView = {
        var img = UIImageView(frame: CGRect(x: 200, y: 200, width: 300, height: 300))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = UIView.ContentMode.scaleAspectFit
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 100
        img.layer.masksToBounds = true
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOpacity = 40
        img.layer.shadowOffset = .zero
        img.layer.shadowRadius = 30
        return img
    }()
    private lazy var scrollView: UIScrollView = {
          let scrollView = UIScrollView()
          scrollView.translatesAutoresizingMaskIntoConstraints = false
          return scrollView
        }()
    

    
    
    
    
    
    var networkManager: NetworkManager?
    override func viewDidLoad() {
        self.nameLabel.text = pokemonName?.capitalized
        view.backgroundColor = .systemBrown
        let dataAdd = getAditionalData(urlPokemonSend: moreInfo)
        _ = dataAdd?.sprites.front_default
        _ = dataAdd?.types.map({$0.type.name})
        self.poke_abilites()
        self.poke_move()
        
        
        guard let img_url = pokemon_atrr?.sprites.front_default else{
            return
        }
        guard let data = ImageCache.shared.getImageData(key: img_url) else {
            return
        }
        let img = UIImage(data: data)
        self.myImageView.image = img!
        
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        
        stackView.addArrangedSubview(self.nameLabel)
        stackView.addArrangedSubview(self.myImageView)
        stackView.addArrangedSubview(self.abilityLabel)
        stackView.addArrangedSubview(self.moveLabel)
        
        self.scrollView.addSubview(stackView)
        self.view.addSubview(self.scrollView)
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
       
    }
    func poke_abilites(){
        var poke_att: String = ""
        for i in 0..<((pokemon_atrr?.abilities.count)!){
            poke_att += (pokemon_atrr?.abilities[i].ability.name)! + ""
        }
        self.abilityLabel.text! += poke_att
    }
    
    func poke_move(){
        var poke_move: String = ""
        for i in 0..<((pokemon_atrr?.moves.count)!){
            if i % 4 == 0{
                poke_move += (pokemon_atrr?.moves[i].move.name)! + "\n"
            }
            poke_move += (pokemon_atrr?.moves[i].move.name)! + "\n Move:"
        }
        self.moveLabel.text = poke_move
    }
}

