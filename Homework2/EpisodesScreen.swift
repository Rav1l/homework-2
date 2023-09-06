import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct EpisodesScreen: View {
    
    @StateObject var episodesVM = EpisodesVM()
    @State var tagNavigation: String?
    
    var body: some View {
        if tagNavigation == "from CharacterDetail" {
            VStack {
                BackButton()
                list
            }
        } else {
            list
        }
    }
    
    func cells(episodes: EpisodesVM) -> some View {
        ForEach(episodesVM.episodes) { episode in
            PushNavStack(destination: EpisodeDetail(name: episode.name,
                                                    episode: episode.episode,
                                                    airDate: episode.airDate)) {
                ListCell(title: "\(episode.episode) - \(episode.name)")
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
    
    var list: some View {
        ScrollView {
            cells(episodes: episodesVM)
        }
        .padding([.leading,.trailing], 17)
        .onAppear {
            if tagNavigation == "from CharacterDetail" {
                episodesVM.fetchMultipleById()
            }
            episodesVM.fetch()
        }
    }
    
}

//struct EpisodesScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodesScreen()
//    }
//}
