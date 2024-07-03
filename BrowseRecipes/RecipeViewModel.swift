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
                self.meals = mealListResponse.meals.sorted { $0.name < $1.name }
            }
        } catch {
            print("Failed to fetch meals: \(error.localizedDescription)")
        }
    }
    
    func fetchMealDetails(mealID: String) async {
        guard let url = URL(string: "\(mealDetailURL)\(mealID)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Meal details JSON response: \(jsonString)")
            }
            let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            DispatchQueue.main.async {
                self.selectedMeal = mealDetailResponse.meals.first
            }
        } catch {
            print("Failed to fetch meal details: \(error.localizedDescription)")
        }
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
