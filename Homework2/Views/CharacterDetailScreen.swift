//
//  CharacterDetailScreen.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 26.08.2023.
//

import SwiftUI
import RickAndMortyApiNetworking
import NavStack


struct CharacterDetailLoadingScreen: View  {
    
    
    @Binding var character: CharacterModel?
    
    var body: some View {
        ZStack {
            if let character = character {
                CharacterDetailScreen(character: character)
            }
        }
    }
    
}

struct CharacterDetailScreen: View {
    
    //MARK: Properties
    
    @EnvironmentObject var locationsVM: LocationsVM
    @EnvironmentObject var episodesVM: EpisodesVM
    
    let character: CharacterModel
    
    //MARK: Views
    
    var body: some View {
        VStack {
            BackButton()
            image
                .padding()
            name
                .padding(.bottom)
            status
            gender
                .padding(.bottom)
            lastLocation
                .padding(.bottom)
            episodes
            Spacer()
        }
    }
    
    //Загрузка изображения через URL
    var image: some View {
        AsyncImage(url: URL(string: character.image)){ image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 300, height: 300)
        .cornerRadius(16)
        .shadow(radius: 20)
    }
    
    //Имя персонажа
    var name: some View {
        Text(character.name)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
    }
    
    //Статус персонажа
    var status: some View {
        Text("\(character.status.rawValue) - \(character.species)")
            .font(.body)
    }
    
    //Гендер персонажа
    var gender: some View {
        Text("Gender: \(character.gender.rawValue)")
    }
    
    //Последня локация, где появляся персонаж
    var lastLocation: some View {
        VStack {
            Text("Last known location")
                .foregroundColor(.secondary)
            //Проверка на наличие локации у персонажа
            //Если локация есть, то можно перейти на экран с информацией о локации (LocationDetail)
            if let locationID = character.location.url.components(separatedBy: "/").last, locationID != "" {
                PushNavStack(destination: LocationDetail(location: locationsVM.lastLocation)) {
                    Text(character.location.name)
                        .foregroundColor(.blue)
                }
                .onAppear {
                    locationsVM.fetcById(id: locationID)
                }
            } else {
                //Если нет, то отобразится текст "unknown"
                Text(character.location.name)
            }
        }
    }
    
    //Список эпизодов, где появлялся персонаж
    var episodes: some View {
        VStack {
            Text("List of episodes in which this character appeared:")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .onAppear {
                    episodesVM.episodesId = character.episode.map { $0.components(separatedBy: "/").last ?? "" }
                }
            //Переход на экран со списком эпизодов (EpisodesScreen), tag нужен для того, чтобы загрузить определённый список эписозод
            PushNavStack(destination: EpisodesScreen(episodesVM: _episodesVM, tagNavigation: "from CharacterDetail")) {
                Text("Episodes")
                    .foregroundColor(.blue)
            }
        }
    }
}
