//
//  DashboardView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 16.10.24.
//

import SwiftUI

struct DashboardView: View {
    
    @Binding var meals:[Entry]
    @Binding var drinks:[Entry]
    @Binding var sweets:[Entry]
    @Binding var fruits:[Entry]
    
    
    
    

    var body: some View {
        let mealCalories: Int = addCalories(entries: meals)
        let drinkCalories: Int = addCalories(entries: drinks)
        let sweetsCalories: Int = addCalories(entries: sweets)
        let fruitCalories: Int = addCalories(entries: fruits)

        var totalCalories: Int {
            mealCalories + drinkCalories + sweetsCalories + fruitCalories
        }
        
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
                        .foregroundColor(Color("lightOrange"))
                }
                .padding()
                .background(Color("lightOrange").opacity(0.1))
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
            
        
    }
}

func addCalories(entries: [Entry])-> Int{
    var calories: Int = 0
    for entry in entries {
            calories += entry.calories
        }
        return calories
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
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview {
    DashboardView(
        meals: .constant([
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

        drinks: .constant([
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

        sweets: .constant([
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

        fruits: .constant([
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
