import XCTest
import SwiftUI
@testable import browseRecipe  // Replace with your app module name
import Combine

class ContentViewViewModelMock: ContentViewViewModel {
    override func fetchMeals(category: String) {
        // Simulating fetching meals instantly for testing
        self.meals = [
            Meal(idMeal: "1", strMeal: "Cake", strMealThumb: "https://example.com/cake.jpg"),
            Meal(idMeal: "2", strMeal: "Ice Cream", strMealThumb: "https://example.com/ice_cream.jpg")
        ]
        self.isLoading = false
    }
}

class ContentViewTests: XCTestCase {
    func testContentView() {
        let viewModel = ContentViewViewModelMock()

        let contentView = ContentView().environmentObject(viewModel)

        let hostingController = UIHostingController(rootView: contentView)

        hostingController.viewWillAppear(false)
        hostingController.viewDidAppear(false)

        viewModel.isLoading = true

        viewModel.isLoading = false
        viewModel.meals = [
            Meal(idMeal: "1", strMeal: "Cake", strMealThumb: ""),
            Meal(idMeal: "2", strMeal: "Ice Cream", strMealThumb: "")
        ]

        let expectation = XCTestExpectation(description: "Wait for view update")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            hostingController.rootView = contentView
            hostingController.viewDidLoad()

            expectation.fulfill()
        }

        // Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0) 
    }

 
}

