//
//  AppInfo.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 18.11.2024.
//

import SwiftUI

struct AppInfo: View {
    let version: String = "Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")"
    
    var body: some View {
        VStack {
            Text("DigiTiptopf")
                .font(.headline)
            Text(version)
                .font(.caption)
        }
    }
}

#Preview {
    AppInfo()
}
