//
//  RecipeListView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI

struct RecipeListView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Recipe List")
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}
