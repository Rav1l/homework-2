import SwiftUI
import RickAndMortyApiNetworking
import NavStack


struct CharactersScreen: View {
    
    @StateObject var charactersVM = CharactersVM()
    @State var episodesId: [String] = []
    var body: some View {
        NavStack {
            List {
                ForEach(charactersVM.characters) { character in
                        
                    PushNavStack(destination: CharacterDetailScreen(image: character.image,
                                                                    name: character.name,
                                                                    status: character.status.rawValue,
                                                                    species: character.species,
                                                                    lastLocationName: character.location.name,
                                                                    lastLocationID: character.location.url.components(separatedBy: "/").last ?? "",
                                                                    firstEpisode: "nil",
                                                                    episodesId: character.episode.map { $0.components(separatedBy: "/").last ?? "" })) {
                        Text(character.name)
                            .onAppear {
                                if charactersVM.characters.isLastItem(character) {
                                    charactersVM.fetch()
                                }
                            }
                    }
                }
            }
            .onAppear {
                charactersVM.fetch()
            }
        }
    }
}

struct CharactersScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharactersScreen()
    }
}
