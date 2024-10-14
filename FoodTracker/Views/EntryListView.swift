//
//  EntryListView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import SwiftUI

struct EntryListView: View {
    @State var mealEntries: [Entry] = [
        Entry(id: "1", title: "Tuna Maki Sushi", date: Date(), calories: 173),
        Entry(id: "2", title: "Chicken Caesar Salad", date: Date(), calories: 350),
        Entry(id: "3", title: "Vegetable Lasagna", date: Date(), calories: 420),
        Entry(id: "4", title: "Grilled Salmon with Asparagus", date: Date(), calories: 380)
    ]

    @State var drinkEntries: [Entry] = [
        Entry(id: "1", title: "Coffee (black)", date: Date(), calories: 2),
        Entry(id: "2", title: "Orange Juice", date: Date(), calories: 112),
        Entry(id: "3", title: "Green Tea", date: Date(), calories: 0),
        Entry(id: "4", title: "Latte", date: Date(), calories: 190)
    ]

    @State var sweetsEntries: [Entry] = [
        Entry(id: "1", title: "Chocolate Chip Cookie", date: Date(), calories: 150),
        Entry(id: "2", title: "Strawberry Ice Cream", date: Date(), calories: 207),
        Entry(id: "3", title: "Snickers Bar", date: Date(), calories: 250),
        Entry(id: "4", title: "Blueberry Muffin", date: Date(), calories: 265)
    ]

    @State var fruitEntries: [Entry] = [
        Entry(id: "1", title: "Apple", date: Date(), calories: 95),
        Entry(id: "2", title: "Banana", date: Date(), calories: 105),
        Entry(id: "3", title: "Orange", date: Date(), calories: 62),
        Entry(id: "4", title: "Kiwi", date: Date(), calories: 61)
    ]

    var body: some View {
        let maxCal = calTrack(2000, mealEntries.count + drinkEntries.count + sweetsEntries.count + fruitEntries.count)
        List {
            EntryListSectionView(maxCal: maxCal, sectionTitle: "Meals", entries: $mealEntries)
            EntryListSectionView(maxCal: maxCal, sectionTitle: "Drinks", entries: $drinkEntries)
            EntryListSectionView(maxCal: maxCal, sectionTitle: "Sweets", entries: $sweetsEntries)
            EntryListSectionView(maxCal: maxCal, sectionTitle: "Fruits", entries: $fruitEntries)
        }
        .listStyle(PlainListStyle())
    }
}

func calTrack(_ caloriens: Int, _ mealTimes: Int) -> Int {
    let recAmount = caloriens / mealTimes
    return recAmount
}

#Preview {
    EntryListView()
        .padding()
}
