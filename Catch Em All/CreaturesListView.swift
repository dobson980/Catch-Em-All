//
//  CreaturesListView.swift
//  Catch Em All
//
//  Created by Thomas Dobson on 8/5/24.
//

import SwiftUI

struct CreaturesListView: View {
    
    @StateObject var creaturesVM = CreaturesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(0..<creaturesVM.creatures.count, id: \.self) { index in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creatures[index])
                        } label: {
                            Text("\(index+1). \(creaturesVM.creatures[index].name.capitalized)")
                                .font(.title2)
                        }
                    }
                    .onAppear() {
                        if let lastCreature = creaturesVM.creatures.last {
                            if creaturesVM.creatures[index].name == lastCreature.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }
                            }
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
