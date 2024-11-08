//
//  ContentView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem { Label("Recipes", systemImage: "tray.full.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    ContentView()
}
