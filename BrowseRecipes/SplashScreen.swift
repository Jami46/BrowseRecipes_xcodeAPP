//
//  SplashScreen.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/3/24.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var showLogo = true
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                Image("Recipe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 20)
                
                if showLogo {
                    Text("DD")
                        .font(.custom("Graphique", size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 216/255, green: 31/255, blue: 38/255)) // #D81F26
                        .transition(.scale)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    showLogo = false
                                }
                            }
                        }
                } else {
                    Text("DELICIOUS DESSERTS")
                        .font(.custom("Graphique", size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 216/255, green: 31/255, blue: 38/255)) // #D81F26
                        .transition(.scale)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    showLogo = true
                                    self.isActive = true
                                }
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
