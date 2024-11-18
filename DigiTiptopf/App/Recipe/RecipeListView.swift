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
    
    @State private var searchQuery: String = ""
    
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
                            RecipeModifyView(recipe: .constant(nil), listStyle: users.first?.listStyle ?? ListStyle.list, name: "", ingredients: [], preparation: [], isEditing: false)
                        } label: {
                            Label("Create recipe", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(.black)
                        
                    }
                    
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 18) {
                            ForEach(filteredRecipes) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipe: recipe, listStyle: users.first?.listStyle ?? ListStyle.list)
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
                                        RecipeModifyView(recipe: .constant(recipe), listStyle: users.first?.listStyle ?? ListStyle.list, name: recipe.name, ingredients: recipe.ingredients, preparation: recipe.preparation, imageData: recipe.image, isEditing: true)
                                    } label: {
                                        Label("Edit Recipe", systemImage: "pencil")
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .searchable(text: $searchQuery)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        RecipeModifyView(recipe: .constant(nil), listStyle: users.first?.listStyle ?? ListStyle.list, name: "", ingredients: [], preparation: [], isEditing: false)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private var filteredRecipes: [Recipe] {
        if searchQuery.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
}



#Preview(traits: .sampleRecipeData) {
    RecipeListView()
}
