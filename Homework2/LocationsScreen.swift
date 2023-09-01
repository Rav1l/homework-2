import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct LocationsScreen: View {
    
    @StateObject var locationsVM = LocationsVM()
    
    var body: some View {
        NavStack {
            List {
                ForEach(locationsVM.locations) { location in
                    PushNavStack(destination: LocationDetail(name: location.name,
                                                             type: location.type,
                                                             demnision: location.dimension)) {
                        Text(location.name)
                            .onAppear {
                                if locationsVM.locations.isLastItem(location) {
                                    locationsVM.fetch()
                                }
                            }
                        
                    }
                }
            }
            .onAppear {
                locationsVM.fetch()
            }
        }
    }
}

struct LocationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationsScreen()
    }
}
