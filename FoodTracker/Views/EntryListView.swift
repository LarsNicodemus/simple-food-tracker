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
    //    @State var selectedEntry: Entry? = nil
    @Binding var mealEntries: [Entry]
    @Binding var drinkEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
    @State private var path = NavigationPath()
    var dailyDrinks: DailyDrinks = DailyDrinks(consumedDrinks: [Drink()])

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
        NavigationStack(path: $path) {
            ZStack {

                List {
                    if mealEntries.isEmpty && drinkEntries.isEmpty
                        && sweetsEntries.isEmpty && fruitEntries.isEmpty
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

                        Section(header: Text("Drinks")) {
                            EntryListSectionView(
                                maxCal: maxCal,
                                showDetailSheet: $showDetailSheet,
                                entries: $drinkEntries)
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
                    Section{
                        HStack{
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
                            Spacer()
                            }
                    }
                    .padding(.bottom,56)
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
                

                VStack {
                    Spacer()
                    HStack {
                        AddSheetView(
                            showSheet: $showSheet, mealEntries: $mealEntries,
                            drinkEntries: $drinkEntries,
                            sweetsEntries: $sweetsEntries,
                            fruitEntries: $fruitEntries)
                        Spacer()
                        NavigationStack(path: $path){
                            Button(action: {
                                path.append(dailyDrinks)
                            }) {
                                Text("Wasser Tracker")
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
                        .navigationDestination(for: DailyDrinks.self) { dailyDrink in
//                            WaterBalanceView(path: $path, dailyDrinks: dailyDrink)
                            WaterBalanceView(dailyDrinks: dailyDrink)

                                    }
                    }

                    .padding(.horizontal)
                    .padding(.bottom, 16)
                }

            }
        }

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
        mealEntries: .constant(MOCKUP_mealEntries),
        drinkEntries: .constant(MOCKUP_drinkEntries),
        sweetsEntries: .constant(MOCKUP_sweetsEntries),
        fruitEntries: .constant(MOCKUP_fruitEntries)
    )

}
