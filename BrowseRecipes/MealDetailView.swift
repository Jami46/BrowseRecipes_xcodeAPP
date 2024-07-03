//
//  MealDetailView.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = RecipeViewModel()
    let mealID: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let meal = viewModel.selectedMeal {
                Text(meal.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Ingredients")
                    .font(.headline)
                
                ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                    Text("\(ingredient): \(measure)")
                }
                
                Text("Instructions")
                    .font(.headline)
                
                Text(meal.instructions)
                    .padding(.top, 5)
            } else {
                ProgressView("Loading...")
            }
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchMealDetails(mealID: mealID)
            }
        }
    }
}
