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
