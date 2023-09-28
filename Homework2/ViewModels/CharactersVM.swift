//
//  CharactersVM.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 29.08.2023.
//

import SwiftUI
import RickAndMortyApiNetworking

final class CharactersVM: ObservableObject {
    //Текущая страница, по умолчанию 1
    private var currentPage = 1
    
    @Published var characters = [CharacterModel]()
    @Published var canLoad = true
    @Published var isFinished = false
    
    init() {
        fetch()
    }
    
    //Получение списка персонажей с подкачкой страниц
    func fetch() {
        Task { @MainActor in
            guard canLoad == true else { return }
            canLoad = false
            do {
                let result = try await CharactersAPI.getAllCharacters(page: self.currentPage)
                isFinished = result.info.next == nil
                
                self.currentPage += 1
                self.characters.append(contentsOf: result.results)
                
                canLoad = !isFinished
            } catch {
                print("Error : \(error)")
                canLoad = true
            }
        }
    }
}
