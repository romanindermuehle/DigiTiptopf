//
//  DigiTiptopfUITests.swift
//  DigiTiptopfUITests
//
//  Created by Roman Indermühle on 08.11.2024.
//

import XCTest

final class DigiTiptopfUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    @MainActor
    func testCreateRecipe() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["plus"].tap()
        
        let recipeNameTextField = app.textFields["recipeName"]
        
        recipeNameTextField.tap()
        
        recipeNameTextField.typeText("Donut")
        
        app.buttons["Add Ingredient"].tap()
        
        app.typeText("Flour")
        
        app.buttons["Add Ingredient"].tap()
        
        app.typeText("Sugar")
        
        app.buttons["Add Step"].tap()
        
        app.typeText("Mix")
        
        app.buttons["Add Step"].tap()
        
        app.typeText("Bake")
        
        app.buttons["Save"].tap()
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let donut = app.staticTexts["Donut"]
        
        XCTAssert(donut.exists)
    }
    
    @MainActor
    func testExportRecipePDF() throws {
        let app = XCUIApplication()
        app.launch()
        
        try testCreateRecipe()
        
        app.staticTexts["Donut"].tap()
        
        let menuButton = app
            .buttons["menuButton"]
            .buttons
            .firstMatch
            .descendants(matching: .any)
            .firstMatch
        
        menuButton.tap()
        
        let sharePDFButton = app.buttons["sharePDFButton"]
        
        sharePDFButton.tap()
        
        let saveToFilesButton = app.descendants(matching: .any).matching(identifier: "Save to Files").firstMatch
        
        saveToFilesButton.tap()
        
        app.buttons["Save"].tap()
    }
    
}
