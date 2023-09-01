//
//  EpisodesVM.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 29.08.2023.
//

import Foundation
import SwiftUI
import RickAndMortyApiNetworking

final class EpisodesVM: ObservableObject {
    
    private var currentPage = 1
    
    @Published var episodes: [EpisodeModel] = []
    @Published var canLoad = true
    @Published var isFinished = false
    @Published var episodesId: [String] = []
    
    func fetch() {
        Task { @MainActor in
            guard canLoad == true else { return }
            canLoad = false
            do {
                let result = try await EpisodesAPI.getAllEpisodes(page: self.currentPage)
                isFinished = result.info.next == nil
                
                self.currentPage += 1
                self.episodes.append(contentsOf: result.results)
                
                canLoad = !isFinished
            } catch {
                print("Error : \(error)")
                canLoad = true
            }
        }
    }
    
    func fetchMultipleById() {
        Task { @MainActor in
            guard canLoad == true else { return }
            canLoad = false
            do {
                switch episodesId.count {
                case 1 :
                    let result = try await EpisodesAPI.getEpisodeById(id: episodesId[0])
                    self.episodes.append(result)
                    canLoad = false
                default:
                    let result = try await EpisodesAPI.getMultipleEpisodeById(ids: self.episodesId)
                    self.episodes.append(contentsOf: result)
                    canLoad = false
                }
                
            } catch {
                print("Error : \(error)")
                canLoad = true
            }
        }
    }
    
}
