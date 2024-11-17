//
//  JSONFile.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 15.11.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct RecipeJSONFile: FileDocument {
    static let readableContentTypes: [UTType] = [.json]
    var recipe: RecipeDTO = RecipeDTO(name: "", ingredients: [], preparation: [])

    init(recipe: RecipeDTO) {
        self.recipe = recipe
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            recipe = try JSONDecoder().decode(RecipeDTO.self, from: data)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(recipe)
        return FileWrapper(regularFileWithContents: data)
    }
}
