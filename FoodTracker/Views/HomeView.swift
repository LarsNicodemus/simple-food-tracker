//
//  HomeView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 16.10.24.
//

import SwiftUI

struct HomeView: View {
    @State var mealEntries: [Entry] = MOCKUP_mealEntries

    @State var dailyDrinks: DailyDrinks = MOCKUP_DailyDrinks1
    @State var sweetsEntries: [Entry] = MOCKUP_sweetsEntries
    @State var fruitEntries: [Entry] = MOCKUP_fruitEntries
    @State private var selection = 0
        var body: some View {
            
            TabView(selection: $selection) {
                Tab("Start", systemImage: "house.fill", value: 0) {
                    EntryListView(mealEntries: $mealEntries, sweetsEntries: $sweetsEntries, fruitEntries: $fruitEntries, dailyDrinks: $dailyDrinks)
                }
                

                Tab("Dashboard", systemImage: "chart.pie.fill", value: 1) {
                    DashboardView(meals: $mealEntries, sweets: $sweetsEntries, fruits: $fruitEntries)
                }
            }
            .accentColor(Color("minti"))
            .tabViewStyle(DefaultTabViewStyle())

            
                    
        }
    }
#Preview {
    HomeView()
}
