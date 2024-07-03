//
//  ContentView.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//

//
//  ContentView.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.id).environmentObject(viewModel)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnail))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text(meal.name)
                    }
                }
            }
            .navigationTitle("Delicious Desserts")
            .onAppear {
                Task {
                    await viewModel.fetchMeals()
                }
            }
        }
        #if os(iOS)
        .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
