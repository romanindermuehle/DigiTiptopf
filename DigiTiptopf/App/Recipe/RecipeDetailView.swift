//
//  RecipeDetailView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    let recipe: Recipe
    let listStyle: String
    @State private var pdfURL: URL?
    
    @State private var showingExporter: Bool = false
    
    var body: some View {
        VStack {
            if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                GeometryReader { geometry in
                    VStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width * 0.9, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        GroupBox(label:
                                    Label("Ingredients:", systemImage: "list.bullet.rectangle")
                        ) {
                            VStack(alignment: .leading) {
                                ForEach(recipe.ingredients, id: \.id) { ingredient in
                                    Text(ingredient.name)
                                    
                                }
                            }
                        }
                        .padding()
                        
                        GroupBox(label:
                                    Label("preparation:", systemImage: "list.number")
                        ) {
                            VStack(alignment: .leading) {
                                ForEach(Array(recipe.preparation.enumerated()), id: \.element) { index, step in
                                    if listStyle == "list" {
                                        HStack {
                                            Circle()
                                                .fill(Color.accentColor)
                                                .frame(width: 38, height: 38)
                                                .overlay {
                                                    Text("\(index)")
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.white)
                                                }
                                            Text(step.name)
                                        }
                                    } else {
                                        Text(step.name)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
        .navigationTitle(recipe.name)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Menu {
                    Section {
                        if let pdfURL {
                            ShareLink(item: pdfURL) {
                                Label("Share as PDF", systemImage: "square.and.arrow.up")
                            }
                        } else {
                            Text("PDF will be created...")
                                .onAppear {
                                    pdfURL = createPDF(recipe: recipe, listStyle: listStyle)
                                }
                        }
                        Button {
                            showingExporter.toggle()
                        } label: {
                            Label("Export as JSON", systemImage: "square.and.arrow.down")
                        }
                    }
                    Section {
                        Button(role: .destructive) {
                            context.delete(recipe)
                            dismiss()
                        } label: {
                            Label("Delete Recipe", systemImage: "trash")
                        }
                        
                        NavigationLink {
                            RecipeModifyView(recipe: .constant(recipe), listStyle: listStyle, name: recipe.name, ingredients: recipe.ingredients, preparation: recipe.preparation, imageData: recipe.image, isEditing: true)
                        } label: {
                            Label("Edit Recipe", systemImage: "pencil")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .fileExporter(isPresented: $showingExporter, document: RecipeJSONFile(recipe: recipe.toDTO()), contentType: .json, defaultFilename: "\(recipe.name)_\(Date().formatted(date: .abbreviated, time: .omitted)).pdf") { result in
            switch result {
            case .success(let url):
                print("Exported to \(url)")
            case .failure(let error):
                print("Export failed: \(error)")
            }
        }
    }
}

#Preview() {
    let recipe = sampleRecipes.first!
    
    RecipeDetailView(recipe: recipe, listStyle: "list")
}
