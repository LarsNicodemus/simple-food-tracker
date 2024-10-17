//
//  Drink.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 17.10.24.
//

import Foundation

struct Drink: Identifiable, Hashable {
    var id: UUID = UUID()
    var quantity: Int = 1
    var type: DrinkCategory = .water
}
