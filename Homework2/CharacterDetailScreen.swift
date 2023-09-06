//
//  CharacterDetailScreen.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 26.08.2023.
//

import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct CharacterDetailScreen: View {
    
    @StateObject var location = LocationsVM()
    @StateObject var episodes = EpisodesVM()
    
    let image: String
    let name: String
    let status: Status
    let gender: Gender
    let species: String
    let lastLocationName: String
    let lastLocationID: String
    let firstEpisode: String
    let episodesId: [String]
    
    var body: some View {
        VStack {
            BackButton()
            //Загрузка изображения через URL
            AsyncImage(url: URL(string: image)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300)
            .cornerRadius(16)
            .shadow(radius: 20)
            .padding()
            VStack {
                //Имя персонажа
                Text(name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                //Статус персонажа
                Text("\(status.rawValue) - \(species)")
                    .font(.body)
                //Гендер персонажа
                Text("Gender: \(gender.rawValue)")
            }
            .padding()
            //Последня локация, где появляся персонаж
            VStack {
                Text("Last known location")
                    .foregroundColor(.secondary)
                //Проверка на наличие локации у персонажа
                //Если локация есть, то можно перейти на экран с информацией о локации (LocationDetail)
                if lastLocationID != "" {
                    PushNavStack(destination: LocationDetail(name: location.lastLocation.name,
                                                             type: location.lastLocation.type,
                                                             demnision: location.lastLocation.dimension)) {
                        Text(lastLocationName)
                            .foregroundColor(.blue)
                    }
                                                             .onAppear {
                                                                 location.fetcById(id: lastLocationID)
                                                             }
                } else {
                    //Если нет, то отобразится текст "unknown"
                    Text(lastLocationName)
                }
            }
            .padding()
            //Список эпизодов, где появлялся персонаж
            Text("List of episodes in which this character appeared:")
                .foregroundColor(.secondary)
                .onAppear {
                    episodes.episodesId = episodesId
                }
            //Переход на экран со списком эпизодов (EpisodesScreen), tag нужен для того, чтобы загрузить определённый список эписозод
            PushNavStack(destination: EpisodesScreen(episodesVM: episodes, tagNavigation: "from CharacterDetail")) {
                Text("Episodes")
                    .foregroundColor(.blue)
            }
            Spacer()
        }
    }
}


//struct CharacterDetailScreen_Previews: PreviewProvider {
//  static var previews: some View {
//        CharacterDetailScreen()
//    }
//}
