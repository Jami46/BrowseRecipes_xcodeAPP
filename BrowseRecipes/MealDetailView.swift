//
//  MealDetailView.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//

import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    let mealID: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let meal = viewModel.selectedMeal {
                    VStack(alignment: .leading, spacing: 10) {
                        // Meal Name
                        Text(meal.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                        
                        // Ingredients List
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Ingredients")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                                Text("\(ingredient): \(measure)")
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        // Instructions
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Instructions")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                            
                            Text(meal.instructions)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(.primary)
                } else {
                    ProgressView("Loading...")
                        .padding()
                }
            }
        }
        .navigationTitle("Recipe Details")
        .onAppear {
            Task {
                await viewModel.fetchMealDetails(mealID: mealID)
            }
        }
    }
}
