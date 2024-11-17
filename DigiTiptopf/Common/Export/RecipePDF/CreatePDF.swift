//
//  RecipePDF.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 16.11.2024.
//

import SwiftUI
import UIKit

@MainActor
func createPDF(recipe: Recipe, listStyle: String) -> URL? {
    let pageSize = CGSize(width: 595.2, height: 841.8) // A4-Größe in Punkten (72 DPI)
    
    let recipePDFView = RecipePDFView(recipe: recipe, listStyle: listStyle)
            .frame(width: pageSize.width, height: pageSize.height)
            .background(Color.white)
    
    let renderer = ImageRenderer(content: recipePDFView)
    renderer.scale = 1.0

    let documentsURL = FileManager.default.temporaryDirectory
    let pdfName = "\(recipe.name)_\(Date().formatted(date: .abbreviated, time: .omitted)).pdf"
    let pdfURL = documentsURL.appendingPathComponent(pdfName)
    
    if let consumer = CGDataConsumer(url: pdfURL as CFURL),
       let context = CGContext(consumer: consumer, mediaBox: nil, nil) {
        let mediaBox = CGRect(origin: .zero, size: pageSize)
        context.beginPDFPage([kCGPDFContextMediaBox as String: mediaBox] as CFDictionary)
        
        renderer.render { size, renderer in
            renderer(context)
        }
        context.endPDFPage()
        context.closePDF()
        return pdfURL
    } else {
        print("Could not create PDF.")
        return nil
    }
}
