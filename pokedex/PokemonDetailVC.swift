//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Hassan Ait-Taleb on 07-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var MainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.uppercased()
        let image =  UIImage(named: String(pokemon.pokedex_id))
        MainImg.image = image
        currentEvoImg.image = image
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }

    func updateUI(){
        descriptionLbl.text = pokemon.descript
        typeLbl.text = pokemon.type
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        defenseLbl.text = pokemon.defence
        attackLbl.text = pokemon.attack
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvoId == ""{
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)

        }
        
        if pokemon.nextEvoLvl == "" , pokemon.nextEvoName != ""{
            evoLbl.text = "Next Evolution \(pokemon.nextEvoName)"
        }else if pokemon.nextEvoLvl == "" , pokemon.nextEvoName == ""{
            evoLbl.text = "No Evolution"
        } else{
            evoLbl.text = "Next Evolution \(pokemon.nextEvoName) LVL \(pokemon.nextEvoLvl)"
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
   
}
