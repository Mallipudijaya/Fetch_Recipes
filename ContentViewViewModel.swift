//
//  ContentViewViewModel.swift
//  browseRecipe
//
//  Created by JAYASHREE MALLIPUDI on 6/25/24.
//

import SwiftUI

class ContentViewViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = true
    
    func fetchMeals(category: String) {
        ApiService.shared.fetchMeals(category: category) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals.sorted { $0.strMeal < $1.strMeal }
                    self.isLoading = false
                case .failure(let error):
                    print("Failed to fetch meals: \(error.localizedDescription)")
                    self.isLoading = false
                }
            }
        }
    }
}
