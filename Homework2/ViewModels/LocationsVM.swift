//
//  LocationsVM.swift
//  Homework2
//
//  Created by Ravil Gubaidulin on 29.08.2023.
//

import Foundation
import SwiftUI
import RickAndMortyApiNetworking

final class LocationsVM: ObservableObject {
    
    private var currentPage = 1
    
    @Published var locations: [LocationModel] = []
    @Published var canLoad = true
    @Published var isFinished = false
    @Published var lastLocation: LocationModel = LocationModel(id: 0,
                                                               name: "",
                                                               type: "",
                                                               dimension: "", 
                                                               residents: [""],
                                                               url: "",
                                                               created: "")
    
    func fetch() {
        Task { @MainActor in
            guard canLoad == true else { return }
            canLoad = false
            do {
                let result = try await LocationsAPI.getAllLocations(page: self.currentPage)
                isFinished = result.info.next == nil
                
                self.currentPage += 1
                self.locations.append(contentsOf: result.results)
                
                canLoad = !isFinished
            } catch {
                print("Error : \(error)")
                canLoad = true
            }
        }
    }
    
    func fetcById(id: String){
        Task { @MainActor in
            do {
                let result = try await LocationsAPI.getLocationById(id: id)
                lastLocation = result
            } catch {
                print("Error : \(error)")
            }
        }
    }
}
