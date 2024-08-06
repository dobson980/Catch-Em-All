//
//  CreaturesListView.swift
//  Catch Em All
//
//  Created by Thomas Dobson on 8/5/24.
//

import SwiftUI

struct CreaturesListView: View {
    
    @StateObject var creaturesVM = CreaturesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        
        var searchResults: [Creature] {
            if searchText.isEmpty {
                return creaturesVM.creatures
            } else {
                return creaturesVM.creatures.filter {$0.name.capitalized.contains(searchText)}
            }
        }
        
        NavigationStack {
            ZStack {
                List(searchResults) { creature in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creature)
                        } label: {
                            Text(creature.name.capitalized)
                                .font(.title2)
                        }
                    }
                    .onAppear() {
                        Task {
                            await creaturesVM.loadNextIfNeed(creature: creature)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await creaturesVM.loadAll()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text("\(creaturesVM.creatures.count) of \(creaturesVM.count)")
                    }
                    
                    
                }
                .searchable(text: $searchText)
                .disableAutocorrection(true)
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }
                
            }
        }
        .task {
            await creaturesVM.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
