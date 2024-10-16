//
//  EntryListView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import SwiftUI

struct EntryListView: View {
    let title = "Entries"
    @State var showAlert = false
    @State var showSheet = false
    @State var showDetailSheet = false
    @State var selectedEntry: Entry? = nil
    @Binding var mealEntries: [Entry]
    @Binding var drinkEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]

    var body: some View {

        let mealCount = if !mealEntries.isEmpty { mealEntries.count } else { 1 }
        let drinkCount =
            if !drinkEntries.isEmpty { calcDrink(drinkEntries).count } else {
                1
            }
        let sweetsCount =
            if !sweetsEntries.isEmpty { sweetsEntries.count } else { 1 }
        let fruitCount =
            if !fruitEntries.isEmpty { fruitEntries.count } else { 1 }

        let maxCal = calcTrack(
            2000, mealCount + drinkCount + sweetsCount + fruitCount)
        NavigationStack {
            ZStack {

                List {
                    if mealEntries.isEmpty && drinkEntries.isEmpty
                        && sweetsEntries.isEmpty && fruitEntries.isEmpty
                    {
                        Section("no Entries availible") {
                            Text("empty")
                        }
                    } else {
                        EntryListSectionView(
                            maxCal: maxCal, sectionTitle: "Meals",
                            showDetailSheet: $showDetailSheet,
                            entries: $mealEntries, selectedEntry: $selectedEntry
                        )
                        EntryListSectionView(
                            maxCal: maxCal, sectionTitle: "Drinks",
                            showDetailSheet: $showDetailSheet,
                            entries: $drinkEntries,
                            selectedEntry: $selectedEntry)
                        EntryListSectionView(
                            maxCal: maxCal, sectionTitle: "Sweets",
                            showDetailSheet: $showDetailSheet,
                            entries: $sweetsEntries,
                            selectedEntry: $selectedEntry)
                        EntryListSectionView(
                            maxCal: maxCal, sectionTitle: "Fruits",
                            showDetailSheet: $showDetailSheet,
                            entries: $fruitEntries,
                            selectedEntry: $selectedEntry)
                    }

                }

                .listStyle(PlainListStyle())
                .padding(.horizontal)

                VStack {
                    Spacer()
                    HStack {
                        AddSheetView(
                            showSheet: $showSheet, mealEntries: $mealEntries,
                            drinkEntries: $drinkEntries,
                            sweetsEntries: $sweetsEntries,
                            fruitEntries: $fruitEntries)
                        Spacer()
                        Button(action: {
                            showAlert = true
                        }) {
                            Text("Alles löschen")
                                .padding()
                                .foregroundColor(.white).bold()
                                .background(
                                    Color(Color("lightOrange")).opacity(0.8)
                                )
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color("lightOrange"), lineWidth: 1)
                                )
                        }

                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                }

            }
        }
        .navigationTitle(title)

        .alert("Einträge Löschen", isPresented: $showAlert) {
            Button("Löschen", role: .destructive) {
                mealEntries.removeAll()
                drinkEntries.removeAll()
                sweetsEntries.removeAll()
                fruitEntries.removeAll()
                showAlert = false
            }
            Button("Abbrechen", role: .cancel) {
                showAlert = false
            }
        } message: {
            Text("möchtest du alles löschen?")
        }

    }
}

func calcDrink(_ entries: [Entry]) -> [Entry] {
    return entries.filter { $0.calories >= 50 }
}

func calcTrack(_ caloriens: Int, _ mealTimes: Int) -> Int {
    let recAmount = caloriens / mealTimes
    return recAmount
}

#Preview {
    EntryListView(
        mealEntries: .constant([
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
        ]),
        drinkEntries: .constant([
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
        ]),
        sweetsEntries: .constant([
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
        ]),
        fruitEntries: .constant([
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
        ])
    )

}
