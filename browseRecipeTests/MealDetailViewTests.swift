import XCTest
import SwiftUI
@testable import browseRecipe

class MealDetailViewTests: XCTestCase {
   

    func testMealDetailViewLoadedState() {
        let viewModel = MealDetailViewModelMock()
        viewModel.fetchMealDetail(mealID: "testMealID")
        
        let contentView = MealDetailView(mealID: "testMealID")
            .environmentObject(viewModel)

        let hostingController = UIHostingController(rootView: contentView)
        hostingController.loadView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Adjust timing as needed
            XCTAssertTrue(hostingController.view.containsText("Mock Meal"), "Expected 'Mock Meal' text to be displayed.")
            XCTAssertTrue(hostingController.view.containsText("Mock instructions"), "Expected 'Mock instructions' text to be displayed.")
            XCTAssertTrue(hostingController.view.containsText("Mock Ingredient 1: 1 cup"), "Expected 'Mock Ingredient 1: 1 cup' text to be displayed.")
            XCTAssertTrue(hostingController.view.containsText("Mock Ingredient 2: 2 tbsp"), "Expected 'Mock Ingredient 2: 2 tbsp' text to be displayed.")
            XCTAssertTrue(hostingController.view.containsImage, "Expected image to be displayed.")
        }
    }
}

//to check presence of specific UI elements
extension UIView {
    var containsProgressView: Bool {
        return subviews.contains { $0 is UIActivityIndicatorView }
    }
    
    func containsText(_ text: String) -> Bool {
        if let label = self as? UILabel {
            return label.text == text
        } else {
            return subviews.contains { $0.containsText(text) }
        }
    }
    
    var containsImage: Bool {
        return subviews.contains { $0 is UIImageView }
    }
}


import Foundation

class MealDetailViewModelMock: MealDetailViewModel  {
   
    
    override func fetchMealDetail(mealID: String) {
        isLoading = true
        
        // Simulating fetching meal detail asynchronously
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in // Simulate delay
            guard let self = self else { return }
            
            // Mock data initialization
            self.mealDetail = MealDetail(idMeal: "testMealID",
                                         strMeal: "Mock Meal",
                                         strInstructions: "Mock instructions",
                                         strMealThumb: "https://example.com/mock.jpg",
                                         strIngredient1: "Mock Ingredient 1",
                                         strIngredient2: "Mock Ingredient 2",
                                         strIngredient3: nil,
                                         strIngredient4: nil,
                                         strIngredient5: nil,
                                         strIngredient6: nil,
                                         strIngredient7: nil,
                                         strIngredient8: nil,
                                         strIngredient9: nil,
                                         strIngredient10: nil,
                                         strIngredient11: nil,
                                         strIngredient12: nil,
                                         strIngredient13: nil,
                                         strIngredient14: nil,
                                         strIngredient15: nil,
                                         strIngredient16: nil,
                                         strIngredient17: nil,
                                         strIngredient18: nil,
                                         strIngredient19: nil,
                                         strIngredient20: nil,
                                         strMeasure1: "1 cup",
                                         strMeasure2: "2 tbsp",
                                         strMeasure3: nil,
                                         strMeasure4: nil,
                                         strMeasure5: nil,
                                         strMeasure6: nil,
                                         strMeasure7: nil,
                                         strMeasure8: nil,
                                         strMeasure9: nil,
                                         strMeasure10: nil,
                                         strMeasure11: nil,
                                         strMeasure12: nil,
                                         strMeasure13: nil,
                                         strMeasure14: nil,
                                         strMeasure15: nil,
                                         strMeasure16: nil,
                                         strMeasure17: nil,
                                         strMeasure18: nil,
                                         strMeasure19: nil,
                                         strMeasure20: nil)

            
            // Simulating loading completion
            self.isLoading = false
        }
    }
}
