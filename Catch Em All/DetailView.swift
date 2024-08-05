//
//  DetailView.swift
//  Catch Em All
//
//  Created by Thomas Dobson on 8/5/24.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var creatureDetailViewModel = CreatureDetailViewModel()
    var creature: Creature
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            HStack {
                Image(systemName: "figure.run.circle")
                    .resizable()
                    .scaledToFit()
                    .backgroundStyle(.white)
                    .frame(height: 96)
                    .cornerRadius(16)
                    .shadow(radius: 8, x:5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                        
                            
                    }
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        
                        Text(String(format: "%.1f", creatureDetailViewModel.height))
                            .font(.largeTitle)
                            .bold()
                        
                    }
                    
                    HStack(alignment: .top) {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        
                        Text(String(format: "%.1f", creatureDetailViewModel.weight))
                            .font(.largeTitle)
                            .bold()
                            
                    }
                }
                
                 
            }
            
            Spacer()
        }
        .padding()
        .task {
            creatureDetailViewModel.urlString = creature.url
            await creatureDetailViewModel.getData()
        }
    }
}

#Preview {
    DetailView(creature: Creature(name: "Charizard", url: "https://pokeapi.co/api/v2/pokemon/6/"))
}
