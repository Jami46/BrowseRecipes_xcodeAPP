//
//  RecipeViewModel.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//
import Foundation

class RecipeViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMeal: MealDetail?
    
    let mealListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let mealDetailURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchMeals() async {
        guard let url = URL(string: mealListURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealListResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
            DispatchQueue.main.async {
                self.meals = mealListResponse.meals
                    .filter { !$0.name.isEmpty && !$0.thumbnail.isEmpty }
                    .sorted { $0.name < $1.name }
            }
        } catch {
            print("Failed to fetch meals: \(error.localizedDescription)")
        }
    }
    
    func fetchMealDetails(mealID: String) async {
        guard let url = URL(string: "\(mealDetailURL)\(mealID)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            DispatchQueue.main.async {
                if let mealDetail = mealDetailResponse.meals.first {
                    self.selectedMeal = MealDetail(
                        id: mealDetail.id,
                        name: mealDetail.name,
                        instructions: mealDetail.instructions,
                        ingredients: mealDetail.ingredients.filter { !$0.isEmpty },
                        measures: mealDetail.measures.filter { !$0.isEmpty }
                    )
                }
            }
        } catch {
            print("Failed to fetch meal details: \(error.localizedDescription)")
        }
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
