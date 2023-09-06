//
//  EpisodeDetail.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 30.08.2023.
//

import SwiftUI
import NavStack

struct EpisodeDetail: View {
    
    let name: String
    let episode: String
    let airDate: String
    
    var body: some View {
        VStack {
            BackButton()
            Spacer()
            Text(name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            Text(episode)
            VStack {
                Text("The air date of the episode:")
                Text(airDate)
                    .font(.title)
            }
            .padding()
            Spacer()
        }
    }
}

//struct EpisodeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodeDetail()
//    }
//}
