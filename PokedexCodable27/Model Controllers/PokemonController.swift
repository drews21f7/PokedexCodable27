//
//  PokemonController.swift
//  PokedexCodable27
//
//  Created by Drew Seeholzer on 6/25/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

class PokemonController {
    
    //Singleton
    static let sharedInstance = PokemonController()
    
    // Create
    func fetchPokemonWith(searchTerm: String, completion: @escaping(TopLevelDictionary?) -> Void) {
        
        //Build URL
        let baseURL = URL(string: "https://pokeapi.co/api/v2")
        // Add /pokemon
        let pokemonPathComponentURL = baseURL?.appendingPathComponent("pokemon")
        // Add /searchTerm
        guard let finalURL = pokemonPathComponentURL?.appendingPathComponent(searchTerm) else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            // Handle the Error
            if let error = error {
                print("There was an error \(error.localizedDescription)")
            }
            //Check if there's data
            if let data = data {
                // decode the data
                do {
                    // Handle the data
                    let pokemon = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    completion(pokemon)
                } catch {
                    print("Error Fetching pokemon!")
                        completion(nil); return
                }
            }
        }.resume()
    }
}
