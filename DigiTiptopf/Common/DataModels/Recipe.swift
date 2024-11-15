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
}
