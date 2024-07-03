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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Delicious Desserts")
                .navigationViewStyle(navigationViewStyle) // Apply appropriate navigation view style
        }
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 300, idealHeight: 600, maxHeight: .infinity) // Apply only to macOS
    }
    
    private var content: some View {
        List(viewModel.meals) { meal in
            NavigationLink(destination: MealDetailView(mealID: meal.id, thumbnailURL: meal.thumbnail).environmentObject(viewModel)) {
                HStack {
                    AsyncImage(url: URL(string: meal.thumbnail))
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(Circle())
                    Text(meal.name)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMeals()
            }
        }
    }
    
    private var imageSize: CGFloat {
        #if os(iOS)
        // Adjust image size based on device and size class
        if horizontalSizeClass == .compact {
            return UIScreen.main.bounds.width * 0.15 // Adjust the multiplier as needed
        } else {
            return 50 // Default size for other cases
        }
        #else
        // For macOS, provide a default image size
        return 50
        #endif
    }
    
    private var navigationViewStyle: some NavigationViewStyle {
        #if os(iOS)
        return StackNavigationViewStyle() // Apply only on iOS
        #else
        return DefaultNavigationViewStyle() // Apply default style for macOS
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait) // Preview orientation for iOS
    }
}
