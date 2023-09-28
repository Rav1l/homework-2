import SwiftUI
import RickAndMortyApiNetworking
import NavStack


struct CharactersScreen: View {
    
    //MARK: Properties
    
    @EnvironmentObject var charactersVM: CharactersVM
    @State var episodesId: [String] = []
    @State var isAnimation: Bool = false
    
    @State private var selectedCharacter: CharacterModel? = nil
    @State var showCharacterDetail: Bool = false
    
    //MARK: Views
    
    var body: some View {
        scrollView
            .background(
                PushNavStack(destination: CharacterDetailLoadingScreen(character: $selectedCharacter),
                             isActive: $showCharacterDetail,
                             label: { })
            )
    }
    
    var scrollView: some View {
        ScrollView {
            getCells(characters: charactersVM.characters)
        }
        .onAppear {
            charactersVM.fetch()
        }
    }
    
    //MARK: Methods
    
    private func getCells(characters: [CharacterModel]) -> some View {
        ForEach(characters) { character in
            ListCell(title: character.name)
                .padding(.horizontal, 17)
                .onTapGesture {
                    segue(character: character)
                }
                .onAppear {
                    if charactersVM.characters.isLastItem(character) {
                        charactersVM.fetch()
                    }
                }
        }
    }
    
    private func segue(character: CharacterModel) {
        selectedCharacter = character
        showCharacterDetail.toggle()
    }
}
