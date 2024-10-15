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
