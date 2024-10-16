//
//  DashboardView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 16.10.24.
//

import SwiftUI

struct DashboardView: View {
    
    
    
    
    
    var mealCalories: Int = 950
    var drinkCalories: Int = 150
    var sweetsCalories: Int = 500
    var fruitCalories: Int = 200

    var totalCalories: Int {
        mealCalories + drinkCalories + sweetsCalories + fruitCalories
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Dashboard")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)

                VStack {
                    Text("Total Calories")
                        .font(.title2)
                        .foregroundColor(.secondary)

                    Text("\(totalCalories) kcal")
                        .font(
                            .system(size: 48, weight: .bold, design: .rounded)
                        )
                        .foregroundColor(.orange)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(12)

                HStack(spacing: 20) {
                    CalorieCategoryView(
                        category: "Meals", calories: mealCalories, color: colorPick(type: .meal, calories: mealCalories, dailyCalories: totalCalories, targetCalories: 2000),
                        dailyCalories: totalCalories)
                    CalorieCategoryView(
                        category: "Drinks", calories: drinkCalories,
                        color: colorPick(type: .drink, calories: drinkCalories, dailyCalories: totalCalories, targetCalories: 2000), dailyCalories: totalCalories)
                }

                HStack(spacing: 20) {
                    CalorieCategoryView(
                        category: "Sweets", calories: sweetsCalories,
                        color: colorPick(type: .sweet, calories: sweetsCalories, dailyCalories: totalCalories, targetCalories: 2000), dailyCalories: totalCalories)
                    CalorieCategoryView(
                        category: "Fruits", calories: fruitCalories,
                        color: colorPick(type: .fruit, calories: fruitCalories, dailyCalories: totalCalories, targetCalories: 2000), dailyCalories: totalCalories)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Kalorienübersicht")
        }
    }
}

func colorPick(
    type: category, calories: Int, dailyCalories: Int, targetCalories: Int
) -> Color {
    var color: Color = Color("minti")
    switch type {
    case .meal:
        if (Double(calories) >= (Double(dailyCalories) * 0.5))
            || (Double(calories) >= (Double(targetCalories) * 0.5))
        {
            color = Color("lightred")
        } else if (Double(calories) >= (Double(dailyCalories) * 0.5))
            || (Double(calories) >= (Double(targetCalories) * 0.5))
        {
            color = Color("lightOrange")
        } else {
            color = Color("minti")
        }
    case .drink:
        if (Double(calories) >= (Double(dailyCalories) * 0.1))
            || (Double(calories) >= (Double(targetCalories) * 0.1))
        {
            color = Color("lightred")
        } else if (Double(calories) >= (Double(dailyCalories) * 0.05))
            || (Double(calories) >= (Double(targetCalories) * 0.05))
        {
            color = Color("lightOrange")
        } else {
            color = Color("minti")
        }
    case .sweet:
        if (Double(calories) >= (Double(dailyCalories) * 0.15))
            || (Double(calories) >= (Double(targetCalories) * 0.15))
        {
            color = Color("lightred")
        } else if (Double(calories) >= (Double(dailyCalories) * 0.1))
            || (Double(calories) >= (Double(targetCalories) * 0.1))
        {
            color = Color("lightOrange")
        } else {
            color = Color("minti")
        }
    case .fruit:
        if (Double(calories) >= (Double(dailyCalories) * 0.2))
            || (Double(calories) >= (Double(targetCalories) * 0.2))
        {
            color = Color("lightred")
        } else if (Double(calories) >= (Double(dailyCalories) * 0.15))
            || (Double(calories) >= (Double(targetCalories) * 0.15))
        {
            color = Color("lightOrange")
        } else {
            color = Color("minti")
        }
    }
    return color
}

struct CalorieCategoryView: View {
    var category: String
    var calories: Int
    var color: Color
    var dailyCalories: Int

    var body: some View {
        VStack {
            Text(category)
                .font(.headline)
                .foregroundColor(.primary)

            Text("\(calories) kcal")
                .font(.title3)
                .bold()
                .foregroundColor(color)

            Circle()
                .trim(
                    from: 0,
                    to: CGFloat(
                        min(Double(calories) / Double(dailyCalories), 1.0))
                )
                .stroke(color, lineWidth: 10)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(-90))
                .padding(.top, 10)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview {
    DashboardView()
}
