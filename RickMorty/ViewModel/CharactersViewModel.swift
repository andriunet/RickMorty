//
//  CharactersViewModel.swift
//  RickMorty
//
//  Created by Andres on 26/11/24.
//

import Foundation
import SwiftUI

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true
    
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters() {
        guard !isLoading else { return }
        
        isLoading = true
        guard let urlString = nextPageURL, let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: response.results)
                    self.nextPageURL = response.info.next
                    self.hasMorePages = response.info.next != nil
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }

    func refreshCharacters() {
        self.characters.removeAll()
        self.nextPageURL = "https://rickandmortyapi.com/api/character"
        self.fetchCharacters()
    }
    
}