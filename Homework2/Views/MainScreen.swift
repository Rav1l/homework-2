import SwiftUI
import NavStack

enum PickerOptions: String, CaseIterable {
    case characters = "Characters"
    case locations = "Locations"
    case episodes = "Episodes"
}

struct MainScreen: View {
    
    @State var segmentationSelection: PickerOptions = .characters
    
    var body: some View {
        NavStack {
            VStack {
                picker
                
                switch segmentationSelection {
                case .characters:
                    CharactersScreen()
                case .locations:
                    LocationsScreen()
                case .episodes:
                    EpisodesScreen()
                }
            }
        }
    }
    
    var picker: some View {
        
        Picker("", selection: $segmentationSelection) {
            ForEach(PickerOptions.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}
