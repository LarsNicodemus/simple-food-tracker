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
    @Binding var mealEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
    @State private var path = NavigationPath()
    @Binding var dailyDrinks: DailyDrinks

    var body: some View {

        let mealCount = if !mealEntries.isEmpty { mealEntries.count } else { 1 }
        let sweetsCount =
            if !sweetsEntries.isEmpty { sweetsEntries.count } else { 1 }
        let fruitCount =
            if !fruitEntries.isEmpty { fruitEntries.count } else { 1 }

        let maxCal = calcTrack(
            2000, mealCount + sweetsCount + fruitCount)
        NavigationStack(path: $path) {
            ZStack {

                List {
                    if mealEntries.isEmpty && sweetsEntries.isEmpty && fruitEntries.isEmpty
                    {
                        Section(header: Text("no Entries availible")) {
                            Text("empty")
                        }
                        .listRowBackground(
                            Color(UIColor.secondarySystemBackground))
                    } else {
                        Section(header: Text("Meals")) {
                            EntryListSectionView(
                                maxCal: maxCal,
                                showDetailSheet: $showDetailSheet,
                                entries: $mealEntries
                            )
                        }
                        .listRowBackground(
                            Color(UIColor.secondarySystemBackground))
                        Section(header: Text("Sweets")) {
                            EntryListSectionView(
                                maxCal: maxCal,
                                showDetailSheet: $showDetailSheet,
                                entries: $sweetsEntries)
                        }
                        .listRowBackground(
                            Color(UIColor.secondarySystemBackground))
                        Section(header: Text("Fruits")) {
                            EntryListSectionView(
                                maxCal: maxCal,
                                showDetailSheet: $showDetailSheet,
                                entries: $fruitEntries)

                        }
                        .listRowBackground(
                            Color(UIColor.secondarySystemBackground))

                    }
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                showAlert = true
                            }) {
                                Text("Delete All")
                                    .padding()
                                    .foregroundColor(.white).bold()
                                    .background(
                                        Color(Color("lightOrange")).opacity(0.8)
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                Color("lightOrange"),
                                                lineWidth: 1)
                                    )
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 56)
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }

                VStack {
                    Spacer()
                    HStack {
                        AddSheetViewTwo(
                            showSheet: $showSheet,
                            dailyDrinks: $dailyDrinks,
                            mealEntries: $mealEntries,
                            sweetsEntries: $sweetsEntries,
                            fruitEntries: $fruitEntries)
                        Spacer()

                        Button(action: {
                            path.append(dailyDrinks)
                        }) {
                            Text("Hydration Tracker")
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
            .alert("Delete all Entries", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    mealEntries.removeAll()
                    sweetsEntries.removeAll()
                    fruitEntries.removeAll()
                    showAlert = false
                }
                Button("Cancel", role: .cancel) {
                    showAlert = false
                }
            } message: {
                Text("do you want to delete all entries?")
            }
            .navigationDestination(for: DailyDrinks.self) { dailyDrink in
                WaterBalanceView(path: $path, dailyDrinks: $dailyDrinks)

            }
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
        mealEntries: .constant(MOCKUP_mealEntries),
        sweetsEntries: .constant(MOCKUP_sweetsEntries),
        fruitEntries: .constant(MOCKUP_fruitEntries),
        dailyDrinks: .constant(MOCKUP_DailyDrinks1)
    )

}
