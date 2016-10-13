//
//  ViewController.swift
//  pokedex
//
//  Created by Hassan Ait-Taleb on 06-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var Collection: UICollectionView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var pokemonArr = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var InSearchModel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Collection.delegate = self
        Collection.dataSource = self
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
    }

    func initAudio(){
        let pathString = Bundle.main.path(forResource: "music", ofType: "mp3")!
        let path = URL(fileURLWithPath: pathString)
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: path)
        } catch let err as NSError {
            print(err.debugDescription)
        }
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
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
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.setImage( UIImage(named: "SoundOff.png") , for: UIControlState.normal)
        }else {
            musicPlayer.play()
            sender.setImage( UIImage(named: "SoundOn.png") , for: UIControlState.normal)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke: Pokemon!
        
        if InSearchModel{
            poke = filteredPokemon[indexPath.row]
        }else {
            poke = pokemonArr[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            if InSearchModel{
                let pokemon = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon)
            }else {
                let pokemon = pokemonArr[indexPath.row]
                cell.configureCell(pokemon)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if InSearchModel{
            return filteredPokemon.count
        }else {
            return pokemonArr.count
        }
        
        
            }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if SearchBar.text == "" || SearchBar.text == nil {
            InSearchModel = false
            view.endEditing(true)
            Collection.reloadData()
        } else {
            InSearchModel = true
            let lower = SearchBar.text!.lowercased()
            filteredPokemon = pokemonArr.filter({ $0.name.range(of: lower) != nil })
            Collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detailsVC = segue.destination as? PokemonDetailVC{
                if let pokemon = sender as? Pokemon{
                    detailsVC.pokemon = pokemon
                }
            }
        }
    }
}

