//
//  Entry.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import Foundation

struct Entry: Identifiable {
    
    var id: String
    var title: String
    var date = Date()
    var calories: Int
    var type: category
    var servingSize: String = "1 Portion"
    var quantity: Int = 1
    var healthRating: HealthRating = .green
    var mealTime: MealTime = .lunch

}
