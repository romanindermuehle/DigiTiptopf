//
//  ListStyle.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 18.11.2024.
//

import Foundation

enum ListStyle: CaseIterable, Identifiable, CustomStringConvertible, Codable {
    case list
    case flowText
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .list: return "List"
        case .flowText: return "Flow Text"
        }
    }
}
