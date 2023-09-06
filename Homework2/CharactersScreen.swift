import SwiftUI
import RickAndMortyApiNetworking
import NavStack


struct CharactersScreen: View {
    
    @StateObject var charactersVM = CharactersVM()
    @State var episodesId: [String] = []
    
    var body: some View {
        list
    }
    
    func cells(characters: CharactersVM) -> some View {
        ForEach(characters.characters) { character in
            PushNavStack(destination: CharacterDetailScreen(image: character.image,
                                                            name: character.name,
                                                            status: character.status,
                                                            gender: character.gender,
                                                            species: character.species,
                                                            lastLocationName: character.location.name,
                                                            lastLocationID: character.location.url.components(separatedBy: "/").last ?? "",
                                                            firstEpisode: "nil",
                                                            episodesId: character.episode.map { $0.components(separatedBy: "/").last ?? "" })) {
                ListCell(title: character.name)
                    .onAppear {
                        if characters.characters.isLastItem(character) {
                            characters.fetch()
                        }
                    }
            }
        }
    }
    
    var list: some View {
        ScrollView {
            cells(characters: charactersVM)
        }
        .padding([.leading,.trailing], 17)
        .onAppear {
            charactersVM.fetch()
        }
    }
}



struct CharactersScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharactersScreen()
    }
}
