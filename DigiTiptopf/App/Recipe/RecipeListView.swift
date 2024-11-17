//
//  RecipeListView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
    @Query(sort: \Recipe.name) var recipes: [Recipe]
    @Query var users: [User]
    @Environment(\.modelContext) var context
    @Namespace var animation
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack {
                if recipes.isEmpty {
                    ContentUnavailableView {
                        Label("Empty recipes", systemImage: "tray")
                    } description: {
                        Text("Create a new recipe to get started.")
                    } actions: {
                        NavigationLink {
                            RecipeModifyView(recipe: .constant(nil), listStyle: users.first?.listStyle ?? "list", name: "", ingredients: [], preparation: [], isEditing: false)
                        } label: {
                            Label("Create recipe", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(.black)
                        
                    }

                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 18) {
                            ForEach(recipes) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipe: recipe, listStyle: users.first?.listStyle ?? "list")
                                        .navigationTransition(.zoom(sourceID: recipe.id, in: animation))
                                } label: {
                                    RecipeCard(imageData: recipe.image, recipeName: recipe.name)
                                        .matchedTransitionSource(id: recipe.id, in: animation)
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        context.delete(recipe)
                                    } label: {
                                        Label("Delete Recipe", systemImage: "trash")
                                    }
                                    
                                    NavigationLink {
                                        RecipeModifyView(recipe: .constant(recipe), listStyle: users.first?.listStyle ?? "list", name: recipe.name, ingredients: recipe.ingredients, preparation: recipe.preparation, imageData: recipe.image, isEditing: true)
                                    } label: {
                                        Label("Edit Recipe", systemImage: "pencil")
                                    }
                                }
                            }
                            
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        RecipeModifyView(recipe: .constant(nil), listStyle: users.first?.listStyle ?? "list", name: "", ingredients: [], preparation: [], isEditing: false)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}



#Preview(traits: .sampleRecipeData) {
    RecipeListView()
}
