import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct LocationsScreen: View {
    
    //MARK: Properties
    
    @EnvironmentObject var locationsVM: LocationsVM
    @State var selectedLoaction: LocationModel? = nil
    @State var showLocationDetailScreen: Bool = false
    
    //MARK: Views
    
    var body: some View {
        list
            .background(
                PushNavStack(destination: LocationLoadingScreen(location: $selectedLoaction),
                             isActive: $showLocationDetailScreen,
                             label: { EmptyView() })
            )
    }
    
    var list: some View {
        ScrollView {
            getCells(locations: locationsVM.locations)
        }
        .onAppear {
            locationsVM.fetch()
        }
    }
    
    //MARK: Methods
    
    private func getCells(locations: [LocationModel]) -> some View {
        ForEach(locations) { location in
            ListCell(title: location.name)
                .padding(.horizontal, 17)
                .onTapGesture {
                    segue(location: location)
                }
                .onAppear {
                    if locationsVM.locations.isLastItem(location) {
                        locationsVM.fetch()
                    }
                }
        }
    }
    
    private func segue(location: LocationModel) {
        selectedLoaction = location
        showLocationDetailScreen.toggle()
    }
}
