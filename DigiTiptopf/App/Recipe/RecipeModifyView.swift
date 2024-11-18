//
//  RecipeModifyView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RecipeModifyView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Binding var recipe: Recipe?
    let listStyle: ListStyle
    
    @FocusState private var focusedIngredient: PersistentIdentifier?
    @FocusState private var focusedStep: PersistentIdentifier?
    
    @State var name: String
    @State var ingredients: [Ingredient]
    @State var preparation: [Step]
    
    @State private var isPhotoPickerShowing: Bool = false
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var capturedImage: UIImage?
    @State private var isShowingCamera: Bool = false
    @State var imageData: Data?
    
    let isEditing: Bool
    
    var body: some View {
        Form {
            Section {
                TextField("Recipe Name", text: $name)
            }
            
            Section("Ingredients") {
                if listStyle == .list {
                    ForEach($ingredients, id: \.id) { $ingredient in
                        TextField("Ingredient", text: $ingredient.name)
                            .onSubmit { addIngredient() }
                            .focused($focusedIngredient, equals: ingredient.id)
                    }
                    
                    Button {
                        addIngredient()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Ingredient")
                        }
                    }
                } else if listStyle == .flowText {
                    TextEditor(text: $ingredients[0].name)
                }
            }
            
            Section("Preparation") {
                if listStyle == .list {
                    ForEach($preparation, id: \.id) { $step in
                        TextField("Step", text: $step.name)
                            .onSubmit { addStep() }
                            .focused($focusedStep, equals: step.id)
                    }
                    
                    Button {
                        addStep()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Step")
                        }
                    }
                } else if listStyle == .flowText {
                    TextEditor(text: $preparation[0].name)
                }
            }
            
            Section("Photo") {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    GeometryReader { geometry in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width)
                        
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                if selectedPhoto == nil && imageData == nil {
                    Menu {
                        Button {
                            isShowingCamera.toggle()
                        } label: {
                            Label("Take Photo", systemImage: "camera")
                        }
                        
                        Button {
                            isPhotoPickerShowing.toggle()
                        } label: {
                            Label("Pick from Library", systemImage: "photo")
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Photo")
                        }
                    }
                } else {
                    Button(role: .destructive) {
                        selectedPhoto = nil
                        imageData = nil
                    } label: {
                        Label("Remove Photo", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView(image: $capturedImage, isPresented: $isShowingCamera)
        }
        .photosPicker(isPresented: $isPhotoPickerShowing, selection: $selectedPhoto, matching: .images, photoLibrary: .shared())
        .onChange(of: selectedPhoto) {
            Task {
                if let selectedPhoto {
                    imageData = await photosPickerItemToData(selectedPhoto)
                }
            }
        }
        .onChange(of: capturedImage) {
            Task {
                if let capturedImage {
                    imageData = uiImageToData(capturedImage)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveRecipe()
                    dismiss()
                }
                .disabled(name.isEmpty)
                .fontWeight(.semibold)
            }
        }
    }
    
    func addIngredient() {
        let ingredient = Ingredient(name: "")
        
        ingredients.append(ingredient)
        focusedIngredient = ingredient.id
    }
    
    func addStep() {
        let step = Step(name: "")
        
        preparation.append(step)
        focusedStep = step.id
    }
    
    func photosPickerItemToData(_ image: PhotosPickerItem) async -> Data? {
        try? await image.loadTransferable(type: Data.self)
    }
    
    func uiImageToData(_ image: UIImage) -> Data? {
        image.jpegData(compressionQuality: 1)
    }
    
    func saveRecipe() {
        if isEditing {
            recipe?.name = name
            recipe?.ingredients = ingredients
            recipe?.preparation = preparation
            recipe?.image = imageData
            
        } else {
            let recipe = Recipe(name: name, ingredients: ingredients, preparation: preparation, image: imageData)
            
            context.insert(recipe)
        }
        
        imageData = nil
        selectedPhoto = nil
    }
    
}

#Preview {
    RecipeModifyView(recipe: .constant(nil), listStyle: ListStyle.list, name: "", ingredients: [], preparation: [], isEditing: false)
}
