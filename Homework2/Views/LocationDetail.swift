//
//  LocationDetail.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 29.08.2023.
//

import SwiftUI
import RickAndMortyApiNetworking
import NavStack

struct LocationLoadingScreen: View {
    @Binding var location: LocationModel?
    
    var body: some View {
        if let location = location {
            LocationDetail(location: location)
        }
    }
}

struct LocationDetail: View {
    
    //MARK: Properties
    
    let location: LocationModel
    
    //MARK: Views
    
    var body: some View {
        VStack {
            BackButton()
            Spacer()
            Text(location.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            VStack {
                Text("The type of the location:")
                Text(location.type)
                    .font(.title)
            }
            .padding()
            VStack {
                Text("The dimension in which the location is located:")
                Text(location.dimension)
                    .font(.title)
            }
            Spacer()
        }
    }
}
