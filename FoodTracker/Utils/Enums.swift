//
//  Enums.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 15.10.24.
//

enum category: String, CaseIterable, Identifiable {
    case meal = "Meal"
    case drink = "Drink"
    case sweet = "Sweet"
    case fruit = "Fruit"
    
    var id: String {rawValue}
}

enum HealthRating: String, CaseIterable, Identifiable {
    case green = "Gesund"
    case yellow = "Mäßig"
    case red = "Ungesund"
    
    var id: String {rawValue}
}

enum MealTime: String, CaseIterable, Identifiable {
    case breakfast = "Frühstück"
    case lunch = "Mittagessen"
    case dinner = "Abendessen"
    case snack = "Snack"
    case drink = "Getränk"
    
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
}
