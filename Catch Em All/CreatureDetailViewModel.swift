//
//  CreatureDetailViewModel.swift
//  Catch Em All
//
//  Created by Thomas Dobson on 8/5/24.
//

import Foundation

@MainActor
class CreatureDetailViewModel: ObservableObject {
    
    private struct DataResponse: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String
    }
    
    var urlString = ""
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL = ""
    
    func getData() async {
        
        print("We are accessing the URL \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            guard let dataResponse = try? JSONDecoder().decode(DataResponse.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                return
            }
            self.height =  dataResponse.height
            self.weight =  dataResponse.weight
            self.imageURL = dataResponse.sprites.front_default
        } catch {
            print("ERROR: Could not get data from \(urlString)")
        }
        
    }
    
}
