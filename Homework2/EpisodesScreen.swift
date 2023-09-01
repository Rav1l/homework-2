import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct EpisodesScreen: View {
    
    @StateObject var episodesVM = EpisodesVM()
    @State var tagNavigation: String?
    
    var body: some View {
        NavStack {
            List {
                ForEach(episodesVM.episodes) { episode in
                    PushNavStack(destination: EpisodeDetail(name: episode.name,
                                                            episode: episode.episode,
                                                            airDate: episode.airDate)) {
                        Text("\(episode.episode) - \(episode.name)")
                            .onAppear {
                                if tagNavigation == "from CharacterDetail" {
                                    episodesVM.fetchMultipleById()
                                }
                                if episodesVM.episodes.isLastItem(episode) {
                                    episodesVM.fetch()
                                }
                            }
                        
                    }
                }
            }
            .onAppear {
                if tagNavigation == "from CharacterDetail" {
                    episodesVM.fetchMultipleById()
                }
                episodesVM.fetch()
            }
        }
    }
    
    
}

//struct EpisodesScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodesScreen()
//    }
//}
