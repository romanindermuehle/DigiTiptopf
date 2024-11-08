//
//  DigiTiptopfApp.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI
import SwiftData

@main
struct DigiTiptopfApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Recipe.self, User.self])
    }
}
