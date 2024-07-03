//
//  Models.swift
//  BrowseRecipes
//
//  Created by Karthik Jami on 7/2/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        
    }
}

struct MealListResponse: Decodable {
    let meals: [Meal]
}

struct MealDetail: Decodable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    let measures: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
                
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        
        
        
    }
}

extension MealDetail {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        var ingredients = [String]()
        var measures = [String]()
        
        for i in 1...20 {
            if let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)"),
               let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
            
            if let measureKey = CodingKeys(stringValue: "strMeasure\(i)"),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmpty {
                measures.append(measure)
            }
        }
        
        self.ingredients = ingredients
        self.measures = measures
        
    }
}
