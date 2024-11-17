//
//  Recipe.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftData
import Foundation

@Model
class Recipe {
    var name: String
    var ingredients: [Ingredient]
    var preparation: [Step]
    @Attribute(.externalStorage) var image: Data?
    
    init(name: String, ingredients: [Ingredient], preparation: [Step], image: Data? = nil) {
        self.name = name
        self.ingredients = ingredients
        self.preparation = preparation
        self.image = image
    }
    
    func toDTO() -> RecipeDTO {
        .init(name: name, ingredients: ingredients.map { $0.name }, preparation: preparation.map { $0.name })
    }
}

struct RecipeDTO: Codable {
    var name: String
    var ingredients: [String]
    var preparation: [String]
}
