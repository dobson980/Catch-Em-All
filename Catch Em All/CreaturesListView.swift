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
            List(creaturesVM.creatures, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            await creaturesVM.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
