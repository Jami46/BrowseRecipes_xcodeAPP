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
    let thumbnailURL: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let meal = viewModel.selectedMeal {
                    
                    // Header with background image and meal name
                    ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: URL(string: thumbnailURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                        .opacity(0.3) // Set the background image opacity
                        
                        Text(meal.name.uppercased())
                            .font(.custom("Copperplate", size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    // Ingredients and Instructions
                    VStack(alignment: .leading, spacing: 10) {
                        Section(header: Text("Ingredients").font(.headline).fontWeight(.bold)) {
                            ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                                Text("\(ingredient): \(measure)")
                            }
                        }
                        
                        Section(header: Text("Instructions").font(.headline).fontWeight(.bold)) {
                            Text(meal.instructions)
                        }
                    }
                    .padding()
                } else {
                    ProgressView("Loading...")
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMealDetails(mealID: mealID)
                }
            }
        }
        .navigationTitle("Recipe Details")
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 300, idealHeight: 600, maxHeight: .infinity)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealID: "53049", thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
            .environmentObject(RecipeViewModel())
    }
}
