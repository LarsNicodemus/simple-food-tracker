//
//  Mockups.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 17.10.24.
//

import Foundation
import SwiftUI

var MOCKUP_entry1: Entry = Entry(
    id: "2", title: "Banana", date: Date(), calories: 105, type: .fruit,
    healthRating: .green)

var MOCKUP_entry2: Entry = Entry(
    id: "2", title: "Strawberry Ice Cream", date: Date(), calories: 207,
    type: .sweet, healthRating: .red)

var MOCKUP_mealEntries: [Entry] = [
    Entry(
        id: "1", title: "Tuna Maki Sushi", date: Date(), calories: 173,
        type: .meal, healthRating: .yellow),
    Entry(
        id: "2", title: "Chicken Caesar Salad", date: Date(), calories: 350,
        type: .meal, healthRating: .yellow),
    Entry(
        id: "3", title: "Vegetable Lasagna", date: Date(), calories: 420,
        type: .meal, healthRating: .green),
    Entry(
        id: "4", title: "Grilled Salmon with Asparagus", date: Date(),
        calories: 380, type: .meal, healthRating: .green),
]

var MOCKUP_drinkEntries: [Entry] = [
    Entry(
        id: "1", title: "Coffee (black)", date: Date(), calories: 2,
        type: .drink, healthRating: .green),
    Entry(
        id: "2", title: "Orange Juice", date: Date(), calories: 112,
        type: .drink, healthRating: .yellow),
    Entry(
        id: "3", title: "Green Tea", date: Date(), calories: 0,
        type: .drink, healthRating: .green),
    Entry(
        id: "4", title: "Latte", date: Date(), calories: 190, type: .drink,
        healthRating: .red),
]

var MOCKUP_sweetsEntries: [Entry] = [
    Entry(
        id: "1", title: "Chocolate Chip Cookie", date: Date(),
        calories: 150, type: .sweet, healthRating: .red),
    Entry(
        id: "2", title: "Strawberry Ice Cream", date: Date(), calories: 207,
        type: .sweet, healthRating: .red),
    Entry(
        id: "3", title: "Snickers Bar", date: Date(), calories: 250,
        type: .sweet, healthRating: .red),
    Entry(
        id: "4", title: "Blueberry Muffin", date: Date(), calories: 265,
        type: .sweet, healthRating: .red),
]

var MOCKUP_fruitEntries: [Entry] = [
    Entry(
        id: "1", title: "Apple", date: Date(), calories: 95, type: .fruit,
        healthRating: .green),
    Entry(
        id: "2", title: "Banana", date: Date(), calories: 105, type: .fruit,
        healthRating: .green),
    Entry(
        id: "3", title: "Orange", date: Date(), calories: 62, type: .fruit,
        healthRating: .green),
    Entry(
        id: "4", title: "Kiwi", date: Date(), calories: 61, type: .fruit,
        healthRating: .green),
]
