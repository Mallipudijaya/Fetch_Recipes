//
//  ApiService.swift
//  browseRecipe
//
//  Created by JAYASHREE MALLIPUDI on 6/25/24.
//

import Foundation

class ApiService {
    static let shared = ApiService()  // Singleton instance
    
    private let baseURL = "https://themealdb.com/api/json/v1/1"
    
    func fetchMeals(category: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/filter.php?c=\(category)") else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                completion(.success(mealsResponse.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMealDetail(mealID: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/lookup.php?i=\(mealID)") else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let mealDetail = mealDetailResponse.meals.first {
                    completion(.success(mealDetail))
                } else {
                    completion(.failure(ApiError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum ApiError: Error {
    case invalidUrl
    case noData
    case invalidResponse
}
