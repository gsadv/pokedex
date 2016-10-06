//
//  Pokemon.swift
//  pokedex
//
//  Created by Hassan Ait-Taleb on 06-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedex_id: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
