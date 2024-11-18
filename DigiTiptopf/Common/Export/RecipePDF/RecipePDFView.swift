//
//  RecipePDFView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 17.11.2024.
//

import SwiftUI

struct RecipePDFView: View {
    var recipe: Recipe
    var listStyle: ListStyle
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer().frame(height: 50)
            Text(recipe.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            RecipeDetailView(recipe: recipe, listStyle: listStyle)
        }
        .padding()
        .background(Color.white)
    }
}
