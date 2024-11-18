//
//  SettingsView.swift
//  DigiTiptopf
//
//  Created by Roman Indermühle on 08.11.2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) var context
    @Query var users: [User]
    @State var selectedListStyle: ListStyle = .list
    
    let listStyles: [String] = ["List", "FlowText"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Formatting") {
                    Picker("List formatting", selection: $selectedListStyle) {
                        ForEach(ListStyle.allCases) { listStyle in
                            Text(String(String(describing: listStyle)))
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .onChange(of: selectedListStyle) {
                        users.first?.listStyle = selectedListStyle
                    }
                }
                
                Section("Contact & Support") {
                    if let url = createMailtoFeedbackURL() {
                        Link(destination: url) {
                            Label("Contact", systemImage: "envelope")
                        }
                        .tint(.primary)
                    }
                }
            }
            .navigationTitle("Settings")
            .overlay(alignment: .bottom) {
                AppInfo()
            }
            .onAppear {
                if users.isEmpty {
                    let user = User(listStyle: .list)
                    context.insert(user)
                } else {
                    selectedListStyle = users.first?.listStyle ?? ListStyle.list
                }
            }
        }
    }
    
    func createMailtoFeedbackURL() -> URL? {
        let email = "rin140613@stud.gibb.ch"
        let subject = "DigiTiptopf - Feedback"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
        let iosVersion = UIDevice.current.systemVersion
        let body =
               """
               
               
               -----
               DigiTiptopf-Version: \("\(appVersion) (\(buildNumber))")
               iOS-Version: \(iosVersion)
               """
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let subject = encodedSubject, let body = encodedBody else {
            return nil
        }
        
        let mailtoURLString = "mailto:\(email)?subject=\(subject)&body=\(body)"
        return URL(string: mailtoURLString)
    }
}

#Preview {
    SettingsView()
}
