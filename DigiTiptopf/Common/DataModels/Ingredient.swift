//
//  Ingredient.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 11.11.2024.
//

import SwiftData
import Foundation

@Model
class Ingredient {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
