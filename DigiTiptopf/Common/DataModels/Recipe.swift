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
    var ingredients: [String]
    var preparation: [String]
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, ingredients: [String], preparation: [String], photo: Data? = nil) {
        self.name = name
        self.ingredients = ingredients
        self.preparation = preparation
        self.photo = photo
    }
}
