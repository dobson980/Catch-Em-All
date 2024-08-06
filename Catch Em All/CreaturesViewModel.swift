//
//  CreaturesViewModel.swift
//  Catch Em All
//
//  Created by Thomas Dobson on 8/5/24.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct DataResponse: Codable {
        var count: Int
        var next: String? //optional later
        var results: [Creature]
    }
    
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon"
    @Published var count = 0
    @Published var creatures: [Creature] = []
    @Published var isLoading = false
    
    func getData() async {
        
        print("We are accessing the URL \(urlString)")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            guard let dataResponse = try? JSONDecoder().decode(DataResponse.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            self.count =  dataResponse.count
            self.urlString = dataResponse.next ?? ""
            self.creatures += dataResponse.results
            isLoading = false
        } catch {
            print("ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
        
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else {
            return
        }
        
        await getData()
        
        await loadAll()
    }
    
}
