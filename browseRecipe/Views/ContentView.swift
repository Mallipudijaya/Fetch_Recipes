import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewViewModel()
    @State private var searchText = ""
    let category = "Dessert"
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search Receipes")
                    .padding(.horizontal)
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else {
                        List(filteredMeals) { meal in
                            NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                                HStack {
                                    if let strMealThumb = meal.strMealThumb,
                                       let url = URL(string: strMealThumb) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                            default:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                            }
                                        }
                                    }

                                    else {
                                        Image(systemName: "photo")
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                    }
                                    Text(meal.strMeal)
                                }
                            }
                        }
                        .navigationTitle("Desserts")

                    }
                }
                .onAppear {
                    viewModel.fetchMeals(category: category)
                }
            }
        }
    }
    
    private var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return viewModel.meals
        } else {
            return viewModel.meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal, 15)
            
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(8)
            }
            .padding(.trailing, 15)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}

