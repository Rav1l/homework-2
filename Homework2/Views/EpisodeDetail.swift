//
//  EpisodeDetail.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 30.08.2023.
//

import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct EpisodeLoadingScreen: View {
    
    @Binding var episode: EpisodeModel?
    
    var body: some View {
        if let episode = episode {
            EpisodeDetail(episode: episode)
        }
    }
}

struct EpisodeDetail: View {
    
    //MARK: Properties
    
    let episode: EpisodeModel
    
    //MARK: Views
    
    var body: some View {
        VStack {
            BackButton()
            Spacer()
            Text(episode.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            Text(episode.episode)
            VStack {
                Text("The air date of the episode:")
                Text(episode.airDate)
                    .font(.title)
            }
            .padding()
            Spacer()
        }
    }
}
