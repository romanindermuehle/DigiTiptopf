//
//  RecipeCard.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 11.11.2024.
//

import SwiftUI

struct RecipeCard: View {
    let imageData: Data?
    let recipeName: String
    
    var body: some View {
        VStack {
            if let imageData {
                if let uIImage = UIImage(data: imageData) {
                    Image(uiImage: uIImage)
                        .resizable()
                        .scaledToFill()
                }
            } else {
                Rectangle()
                    .fill(.accent)
                    .overlay {
                        Image(systemName: "frying.pan")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .scaledToFill()
                    }
            }
        }
        .frame(width: 180, height: 150)
        .overlay(alignment: .bottom) {
            Text(recipeName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 200, height: 50)
                .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
