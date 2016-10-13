//
//  Pokemon.swift
//  pokedex
//
//  Created by Hassan Ait-Taleb on 06-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedex_id: Int {
        return _pokedexId
    }
    
    var descript: String {
        if _description == nil{
        _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defence: String {
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var pokedexId: Int {
        if _pokedexId == nil{
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil{
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil{
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        let urlString = URL(string: _pokemonUrl)!
        Alamofire.request(urlString).responseJSON { (response: DataResponse<Any>) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let height = dict["height"] as? String{
                    self._height = "\(height)"
                }
                
                if let weight = dict["weight"] as? String{
                    self._weight = "\(weight)"
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                self._type = ""
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                   
                    for type in types{
                        let d = type["name"]!
                        if types.count == 1 {
                            self._type! += "\(d)"
                        } else {
                        self._type! += "/\(d)"
                        }
                    }
                    print(self._type.capitalized)
                    
                    if let type = types[0]["name"]{
                       //print("hassan \(type)")
                    }
                }
                
                if let descr = dict["descriptions"] as? [Dictionary<String, String>], descr.count > 0 {
                    
                    if let descUrl = descr[0]["resource_uri"]{
                        print("hassan \(descUrl)")
                        let newUrl = "\(URL_BASE)\(descUrl)"
                        
                        let urlDesc = URL(string: newUrl)!
                        Alamofire.request(urlDesc).responseJSON { (response: DataResponse<Any>) in
                            
                            if let dictDesc = response.result.value as? Dictionary<String, AnyObject>{
                            
                                if let description = dictDesc["description"] as? String{
                                    self._description = description
                                    //print(description)
                                }
                            }
                            completed()
                        }
                        
                    }
                }
                
                if let evo = dict["evolutions"] as? [Dictionary<String, AnyObject>], evo.count > 0 {
                    
                    if let to = evo[0]["to"] as? String{
                        
                        if !to.contains("mega") {
                            self._nextEvoName = to
                            print("hassan1 \(to)")
                            
                            if let uri = evo[0]["resource_uri"] as? String{
                                let uriInt = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "").replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = uriInt
                                print("hassan2 \(self._nextEvoId)")
                            }
                            
                            if let lvl = evo[0]["level"] as? Int{
                                self._nextEvoLvl =  "\(lvl)"
                            }
                            
                        }
                    }
                }
            }
            
        }
    }    
}
