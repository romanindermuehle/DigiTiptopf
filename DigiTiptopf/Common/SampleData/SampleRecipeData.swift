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
    Recipe(name: "Pizza", ingredients: ["Tomato", "Cheese", "Ham"], preparation: ["Mix all ingredients", "Bake in oven"], image: UIImage(resource: .pizza).jpegData(compressionQuality: 1)),
    Recipe(name: "Donut", ingredients: ["Flour", "Sugar", "Eggs"], preparation: ["Mix all ingredients", "Bake in oven"], image: UIImage(resource: .donuts).jpegData(compressionQuality: 1)),
    Recipe(name: "Cake", ingredients: ["Flour", "Sugar", "Eggs"], preparation: ["Mix all ingredients", "Bake in oven"])
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
