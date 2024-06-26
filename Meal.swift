//
//  Meal.swift
//  browseRecipe
//
//  Created by JAYASHREE MALLIPUDI on 6/25/24.
//

import Foundation
import SwiftUI

struct Meal: Identifiable, Codable, Equatable{
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
    
    var id: String { idMeal }
}

struct MealsResponse: Codable {
    let meals: [Meal]
}
