//
//  WaterBalanceView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 17.10.24.
//

import SwiftUI

struct WaterBalanceView: View {
    @Binding var path: NavigationPath
    var dailyDrinks: DailyDrinks
    var body: some View {
        ForEach(dailyDrinks.consumedDrinks){ drink in
            Text("\((drink.type.rawValue))")
            
        }
    }
}

//#Preview {
//    WaterBalanceView()
//}
