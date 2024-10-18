//
//  DailyDrinks.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 17.10.24.
//
import Foundation

struct DailyDrinks: Identifiable, Hashable {
    var id: UUID = UUID()
    var date: Date = Date()
    var goal: Int = 2000
    var consumedDrinks: [Drink]
}
