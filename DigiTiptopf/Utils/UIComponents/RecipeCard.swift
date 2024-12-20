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
                Color.accent
                    .overlay {
                        Image(systemName: "frying.pan")
                            .resizable()
                            .frame(width: 120, height: 80, alignment: .center)
                            .scaledToFill()
                            .foregroundStyle(.black)
                            .padding(.bottom, 35)
                    }
            }
        }
        .frame(width: 180, height: 150)
        .overlay(alignment: .bottom) {
            Text(recipeName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
                .containerRelativeFrame(.horizontal) { width, _ in
                    width * 0.4
                }
                .padding(.horizontal, 10)
                .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
