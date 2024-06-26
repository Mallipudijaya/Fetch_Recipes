import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    
    func fetchMealDetail(mealID: String) {
        isLoading = true
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let mealDetailResponse = try? JSONDecoder().decode(MealDetailResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.mealDetail = mealDetailResponse.meals.first
                        self.isLoading = false
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            self.isLoading = false
        }.resume()
    }
}

