import SwiftUI

@main
struct Homework2App: App {
    
    @StateObject var charactersVM = CharactersVM()
    @StateObject var locationVM = LocationsVM()
    @StateObject var episodesVM = EpisodesVM()
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environmentObject(charactersVM)
                .environmentObject(locationVM)
                .environmentObject(episodesVM)
        }
    }
}
