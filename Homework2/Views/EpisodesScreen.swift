import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct EpisodesScreen: View {
    
    //MARK: Properties
    
    @EnvironmentObject var episodesVM: EpisodesVM
    @State var tagNavigation: String?
    
    @State var selectedEpisode: EpisodeModel? = nil
    @State var showDetailEpisodeScreen: Bool = false
    
    //MARK: Views
    
    var body: some View {
        ZStack {
            if tagNavigation == "from CharacterDetail" {
                VStack {
                    BackButton()
                    scrollView
                }
            } else {
                scrollView
            }
        }
        .background(
            PushNavStack(destination: EpisodeLoadingScreen(episode: $selectedEpisode),
                         isActive: $showDetailEpisodeScreen,
                         label: { EmptyView() })
        )
    }
    
   
    
    var scrollView: some View {
        ScrollView {
            getCells(episodes: episodesVM.episodes)
        }
        .onAppear {
            if tagNavigation == "from CharacterDetail" {
                episodesVM.fetchMultipleById()
            }
            episodesVM.fetch()
        }
    }
    
    //MARK: Methods
    
    private func getCells(episodes: [EpisodeModel]) -> some View {
        ForEach(episodes) { episode in
                ListCell(title: "\(episode.episode) - \(episode.name)")
                .padding(.horizontal, 17)
                .onTapGesture {
                    segue(episode: episode)
                }
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
    
    private func segue(episode: EpisodeModel) {
        selectedEpisode = episode
        showDetailEpisodeScreen.toggle()
    }
    
}

//struct EpisodesScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodesScreen()
//    }
//}
