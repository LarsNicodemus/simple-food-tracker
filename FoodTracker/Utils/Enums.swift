//
//  Enums.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 15.10.24.
//

enum category: String, CaseIterable, Identifiable {
    case meal = "Meal"
    case sweet = "Sweet"
    case fruit = "Fruit"
    
    var id: String {rawValue}
}

enum HealthRating: String, CaseIterable, Identifiable {
    case green = "Healthy"
    case yellow = "Moderate"
    case red = "Unhealthy"
    
    var id: String {rawValue}
}

enum MealTime: String, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    
    var id: String {rawValue}
}

enum DrinkCategory: String, CaseIterable, Identifiable {
    case water = "Water"
    case tea = "Tea"
    case coffee = "Coffee"
    case juice = "Juice"
    case soda = "Soda"
    case beverage = "Beverage"
    
    
    var id: String {rawValue}
    
    var symbolName: String {
        switch self {
        case .water:
            return "waterbottle.fill"
        case .tea:
            return "mug.fill"
        case .coffee:
            return "cup.and.saucer.fill"
        case .juice:
            return "homepod.fill"
        case .soda:
            return "drop.fill"
        case .beverage:
            return "wineglass.fill"
        }
    }
}

enum DateChoice: String, CaseIterable, Identifiable {
    case day = "Daily"
    case week = "Weekly"
    case month = "Monthly"
    
    var id: String {rawValue}
}
