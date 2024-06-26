import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @ObservedObject private var viewModel = MealDetailViewModel()
    @State private var selectedIngredientIndex: Int?=3

    var body: some View {
        Group {
            if let mealDetail = viewModel.mealDetail {
                ScrollView {
//                    if let strMealThumb = mealDetail.strMealThumb, let url = URL(string: strMealThumb) {
//                        AsyncImage(url: url)
//                            .frame(width: 200, height: 200)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
                    if let strMealThumb = mealDetail.strMealThumb, let url = URL(string: strMealThumb) {
                        GeometryReader { geometry in
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: 200)
                                        .clipped()
                                        .cornerRadius(10)
                                case .empty, .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: 200)
                                        .clipped()
                                        .cornerRadius(10)
                                @unknown default:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: 200)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .frame(height: 200)
                                       }
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Instructions Section
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Instructions")
                            .font(.headline)
                            .underline()
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                       
                        Text(mealDetail.strInstructions)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    
                    
                    
                    
                    // Ingredients Section
                    Text("Ingredients")
                        .font(.headline)
                        .underline()
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .padding(.vertical, 1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    
                
                }
                .disabled(viewModel.isLoading)
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.fetchMealDetail(mealID: mealID)
                    }
            }
        }
        .navigationBarTitle("Meal Detail", displayMode: .inline)
        .onDisappear {
            viewModel.mealDetail = nil // Resets state when view disappears
        }
    }
}

#Preview {
    MealDetailView(mealID: "52860")
}

