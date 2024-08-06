//
//  Creature.swift
//  Catch Em All
//
//  Created by Thomas Dobson on 8/5/24.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String //url for detail on pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
