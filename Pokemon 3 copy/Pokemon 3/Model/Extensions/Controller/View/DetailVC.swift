//
//  DetailVC.swift
//  Pokemon 3
//
//  Created by Consultant on 5/9/22.
//

//import UIKit
//
//class PokeDetailsViewController: UIViewController {
//    // Set up table view
//    lazy var PokeDetailsTableView: UITableView = {
//        let tableview = UITableView(frame: .zero)
//        tableview.translatesAutoresizingMaskIntoConstraints = false
//        tableview.delegate = self
//        tableview.backgroundColor = .white
//        tableview.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseID)
//            return tableview
//        }()
//    
//    var namePokemon = String()
//    var moreInfo = String()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .lightGray
//        
//        
//        
//        let dataAdd = getAditionalData(urlPokemonSend: moreInfo)
//        
//        let spritesFront = dataAdd?.sprites.front_default
//        let pokemonName = namePokemon
//        let typesOfPokemon = dataAdd?.types.map({$0.type.name})
//        let height = (dataAdd?.height)
//        let pokeAbilities = dataAdd?.abilities.map({$0.ability.name})
//        
//        let counttAbilities = pokeAbilities!.count
//        var abili = ""
//        for i in 0...counttAbilities-1{
//            var comma = ""
//            if i == counttAbilities-1{
//                comma = ""
//            }else{
//                comma = ", "
//            }
//            abili = abili + pokeAbilities![i] + comma
//        }
//        
//        var unwUrl = ""
//        if let unwrapped = spritesFront {
//            unwUrl = unwrapped
//        } else {
//        }
//        var unwrapW = 0
//        if let unwrappedW = height {
//            unwrapW = height!
//        } else {
//        }
//        
//        let url = URL(string: unwUrl)
//        fetchImage(url)
//        func fetchImage(_ photoURL: URL?) {
//            guard let imageURL = photoURL else { return  }
//            DispatchQueue.global(qos: .userInitiated).async {
//                do{
//                    //Setting the contens of the url data
//                    let imageData: Data = try Data(contentsOf: imageURL)
//                    DispatchQueue.main.async {
//                        
//                        let screenWidth = UIScreen.main.bounds.size.width
//                        let screenHeight = UIScreen.main.bounds.size.height
//                        let view = UIView()
//                        view.backgroundColor = .white
//                        let image = UIImage(data: imageData)
//                        let myImageView:UIImageView = UIImageView(frame: CGRect(x:screenWidth/2.5, y: 30, width: 200, height: 200))
//                        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
//                        myImageView.image = image
//                        view.addSubview(myImageView)
//                        self.view = view
//                        
//                        let labelName = UILabel(frame: CGRect(x: screenWidth/6, y: screenHeight/4, width: 400, height: 50))
//                            labelName.font = UIFont(name: "HelveticaNeue-Bold", size: 40.0)
//                            labelName.text = pokemonName.capitalized
//                            labelName.textColor = .red
//                        self.view.addSubview(labelName)
//                        
//                        let typeCount = typesOfPokemon!.count
//                        var typeNames = ""
//                        for i in 0...typeCount-1{
//                            
//                            var coma = ""
//                            if i == counttAbilities-1{
//                                coma = ""
//                            }else{
//                                coma = ", "
//                            }
//                            typeNames = typeNames + typesOfPokemon![i] + coma
//                        }
//                        let labelType = UILabel(frame: CGRect(x: screenWidth/6, y: screenHeight/3, width: 400, height: 100))
//                            labelType.text = "Type: \(typeNames.capitalized)"
//                            labelType.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30.0)
//                            labelType.textColor = .red
//                        self.view.addSubview(labelType)
//                        
//                        let abilitiesLabel = UILabel(frame: CGRect(x: screenWidth/6, y: screenHeight/2.5, width: 400, height: 100))
//                            abilitiesLabel.text = "Abilities : \(abili.capitalized)"
//                            abilitiesLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18.0)
//                            abilitiesLabel.textColor = .red
//                        self.view.addSubview(abilitiesLabel)
//                        
//                        let weightLabel = UILabel(frame: CGRect(x: screenWidth/6, y: screenHeight/2.3, width: 400, height: 100))
//                        weightLabel.text = "Weight : \(unwrapW)"
//                        weightLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18.0)
//                        weightLabel.textColor = .red
//                        self.view.addSubview(weightLabel)
//                    }
//                }catch{
//                    print("Unable to load data: \(error)")
//                }
//            }
//        }
//    }
//    
//}
//extension PokeDetailsViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//}
//
//
////extension PokeDetailsViewController: UITableViewDataSource {
////
//////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//////        return 0
//////    }
//////
//////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//////        guard let cell = PokeDetailsTableView.dequeueReusableCell(withIdentifier: PokeDetailsTableView.reuseId, for: indexPath) as? PokeDetailsViewController else{
//////            return UITableViewCell ()
//////        }
//////        return cell
//////    }
////
////}
////import Foundation
////import UIKit
////
////class DetailVC: UIViewController {
////    var pokemonName = String()
////    var moreInfo = String()
////
////    override func viewDidLoad() {
////        print("fdsafds")
////        view.backgroundColor = .systemBrown
////        let dataAdd = getAditionalData(urlPokemonSend: moreInfo)
////        let spritesFront = dataAdd?.sprites.front_default
////        let typesOfPokemon = dataAdd?.types.map({$0.type.name})
////        let abilitysOfPokemon = dataAdd?.abilities.map({$0.ability.name})
////        print(abilitysOfPokemon ?? "")
////
////
////        let counttAbilities = typesOfPokemon!.count
////                var abili = ""
////                for i in 0...counttAbilities-1{
////                    abili = abili + typesOfPokemon![i] + " "
////                }
////
////        var unwUrl = ""
////
////               if let unwrapped = spritesFront {
////                   unwUrl = unwrapped
////               } else {
////
////               }
////
////
////
////
////        let url = URL(string: unwUrl)
////                fetchImage(url)
////
////        func fetchImage(_ photoURL: URL?) {
////                    guard let imageURL = photoURL else { return  }
////                    DispatchQueue.global(qos: .userInitiated).async {
////                        do{
////
////                            let imageData: Data = try Data(contentsOf: imageURL)
////                            DispatchQueue.main.async { [self] in
////
////                                let screenWidth = UIScreen.main.bounds.size.width
////                                let screenHeight = UIScreen.main.bounds.size.height
////                                print("screen width \(screenWidth)")
////
////
////                                let view = UIView()
////                                view.backgroundColor = .systemBrown
////                                let image = UIImage(data: imageData)
////                                let myImageView:UIImageView = UIImageView(frame: CGRect(x: screenWidth/4, y: screenHeight/4, width: 200, height: 200))
////                                myImageView.contentMode = UIView.ContentMode.scaleAspectFit
////                                myImageView.image = image
////                                myImageView.backgroundColor = .white
////                                myImageView.layer.masksToBounds = true
////                                myImageView.layer.cornerRadius = 100
////                                myImageView.layer.borderColor = UIColor.systemGray2.cgColor
////                                myImageView.layer.borderWidth = 7.0
////                                view.addSubview(myImageView)
////                                self.view = view
////
////                                let width = UIScreen.main.bounds.size.width
////                                let height = UIScreen.main.bounds.size.height
////
////                                let labelName = UILabel(frame: CGRect(x: width/4, y: height/9, width: 200, height: 50))
////                                labelName.font = UIFont(name: "Helvetica-Bold", size: 35.0)
////                                labelName.text = self.pokemonName.capitalized
////                                labelName.textColor = .black
////                                labelName.backgroundColor = .white
////                                labelName.layer.masksToBounds = true
////                                labelName.layer.cornerRadius = 5
////                                labelName.numberOfLines = 0
////                                labelName.frame.origin.y = 0
////                                labelName.frame.origin.x = self.view.frame.width - labelName.frame.width
////                                [labelName .sizeToFit()]
////                                self.view.addSubview(labelName)
////
////                                let typeOfLabel = UILabel(frame: CGRect(x: width/4, y: 400, width: 200, height: 100))
////                                typeOfLabel.text = "Type: \(abili)"
////                                typeOfLabel.font = UIFont(name: "Georgia-Italic", size: 25.0)
////                                typeOfLabel.textColor = .black
////                                typeOfLabel.backgroundColor = .white
////                                typeOfLabel.layer.masksToBounds = true
////                                labelName.layer.cornerRadius = 5
////                                typeOfLabel.numberOfLines = 0
////                                typeOfLabel.textAlignment = .center
////                                typeOfLabel.frame.origin.x = 0
////                                typeOfLabel.frame.origin.y = self.view.frame.height - typeOfLabel.frame.height
////                                [typeOfLabel .sizeToFit()]
////                                self.view.addSubview(typeOfLabel)
////
////                                //
////                                let abilityLabel = UILabel(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
////                                abilityLabel.text = "Abilities: \(abilitysOfPokemon)"
////                                abilityLabel.font = UIFont(name: "Georgia-Italic", size: 25.0)
////                                abilityLabel.textColor = .black
////                                abilityLabel.backgroundColor = .white
////                                abilityLabel.layer.masksToBounds = true
////                                abilityLabel.layer.cornerRadius = 5
////                                abilityLabel.numberOfLines = 0
////                                abilityLabel.textAlignment = .center
////                                [abilityLabel .sizeToFit()]
////                                self.view.addSubview(abilityLabel)
////                                //
////
////                            }
////                        }catch{
////                            print("Unable to load data: \(error)")
////                        }
////                    }
////                }
////    }
////}
////
