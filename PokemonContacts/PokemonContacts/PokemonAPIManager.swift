//
//  PokemonAPIManager.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import Foundation

class PokemonAPIManager {
    static let shared = PokemonAPIManager()

    func fetchRandomPokemonImage(completion: @escaping (String?) -> Void) {
        let randomID = Int.random(in: 1...1000)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let sprites = json?["sprites"] as? [String: Any],
                   let imageURL = sprites["front_default"] as? String {
                    completion(imageURL)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
