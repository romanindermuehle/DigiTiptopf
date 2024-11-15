//
//  SampleRecipeData.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 11.11.2024.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor let sampleRecipe: [Recipe] = [
    Recipe(name: "Pizza", ingredients: [Ingredient(name: "Tomato"), Ingredient(name: "Cheese")], preparation: [Step(name: "Mix all ingredients"), Step(name: "Bake in oven")], image: UIImage(resource: .pizza).jpegData(compressionQuality: 1)),
    Recipe(name: "Donut", ingredients: [Ingredient(name: "Flour"), Ingredient(name: "Sugar"), Ingredient(name: "Eggs")], preparation: [Step(name: "Mix all ingredients"), Step(name: "Bake in oven")], image: UIImage(resource: .donuts).jpegData(compressionQuality: 1)),
    Recipe(name: "Cake", ingredients: [Ingredient(name: "Flour"), Ingredient(name: "Sugar"), Ingredient(name: "Eggs")], preparation: [Step(name: "Mix all ingredients"), Step(name: "Bake in oven")])
]

struct SampleRecipeData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let container = try ModelContainer(for: Recipe.self, User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        for recipe in sampleRecipe {
            container.mainContext.insert(recipe)
        }
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var sampleRecipeData: Self = .modifier(SampleRecipeData())
}
