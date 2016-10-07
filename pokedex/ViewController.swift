//
//  ViewController.swift
//  pokedex
//
//  Created by Hassan Ait-Taleb on 06-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var Collection: UICollectionView!
    
    var pokemonArr = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Collection.delegate = self
        Collection.dataSource = self
        parsePokemonCSV()
    }

    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let pokId = Int(row["id"]!)!
                let name = row["identifier"]!
                let pokemon = Pokemon(name: name, pokedexId: pokId)
                pokemonArr.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            var pokemon = pokemonArr[indexPath.row]
            //Pokemon(name: "PokiTest", pokedexId: indexPath.row)
            cell.configureCell(pokemon: pokemon)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
}

