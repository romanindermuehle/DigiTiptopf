//
//  DigiTiptopfTests.swift
//  DigiTiptopfTests
//
//  Created by Roman Indermühle on 08.11.2024.
//

@testable import DigiTiptopf
import Testing
import Foundation

struct DigiTiptopfTests {
    
    @MainActor
    @Test func createFeedbackURLSuccessful() throws {
        let settingsView = SettingsView()
        
        let feedbackURL = settingsView.createMailtoFeedbackURL()
        
        let expectedFeedbackURL: String = "mailto:rin140613@stud.gibb.ch?subject=DigiTiptopf%20-%20Feedback&body=%0A%0A-----%0ADigiTiptopf-Version:%201.0%20(1)%0AiOS-Version:%2018.1"
        
        guard let resultFeedbackURL = URL(string: expectedFeedbackURL) else { return }
        
        #expect(feedbackURL == resultFeedbackURL)
    }
}
