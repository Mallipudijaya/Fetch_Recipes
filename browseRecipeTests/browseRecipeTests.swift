//
//  browseRecipeTests.swift
//  browseRecipeTests
//
//  Created by JAYASHREE MALLIPUDI on 6/25/24.
//

import XCTest
@testable import browseRecipe
import SwiftUI

class BrowseRecipeAppTests: XCTestCase {
    func testAppInitialization() {
          // Initialize the app
          let app = browseRecipeApp()

          // Access the main view from the app's body
          let contentView = app.body

          // Assert that the main view is instantiated correctly
          XCTAssertNotNil(contentView)
      }
   
}


