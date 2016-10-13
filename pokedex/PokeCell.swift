//
//  PokeCell.swift
//  pokedex
//
//  Created by Hassan Ait-Taleb on 06-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.uppercased()
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedex_id)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
}
