import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct LocationsScreen: View {
    
    @StateObject var locationsVM = LocationsVM()
    
    var body: some View {
        list
    }
    
    func cells(loactions: LocationsVM) -> some View {
        ForEach(locationsVM.locations) { location in
            PushNavStack(destination: LocationDetail(name: location.name,
                                                     type: location.type,
                                                     demnision: location.dimension)) {
                ListCell(title: location.name)
                    .onAppear {
                        if locationsVM.locations.isLastItem(location) {
                            locationsVM.fetch()
                        }
                    }
            }
        }
    }
    
    var list: some View {
        ScrollView {
            cells(loactions: locationsVM)
        }
        .padding([.leading,.trailing], 17)
        .onAppear {
            locationsVM.fetch()
        }
    }
}

struct LocationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationsScreen()
    }
}
