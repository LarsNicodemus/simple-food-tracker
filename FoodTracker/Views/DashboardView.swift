//
//  DashboardView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 16.10.24.
//

import SwiftUI

struct DashboardView: View {
    @Binding var meals: [Entry]
    @Binding var sweets: [Entry]
    @Binding var fruits: [Entry]
    @State private var selectedStartDate = Date()
    @State private var selectedEndDate = Date()

    var body: some View {
        let filteredMeals = filterEntriesByDate(entries: meals)
        let filteredSweets = filterEntriesByDate(entries: sweets)
        let filteredFruits = filterEntriesByDate(entries: fruits)
        let mealCalories = addCalories(entries: filteredMeals)
        let sweetsCalories = addCalories(entries: filteredSweets)
        let fruitCalories = addCalories(entries: filteredFruits)
        let totalCalories = mealCalories + sweetsCalories + fruitCalories
        let numberOfDays = calculateNumberOfDays(startDate: selectedStartDate, endDate: selectedEndDate)
        let averageCaloriesPerDay = numberOfDays > 0 ? totalCalories / numberOfDays : totalCalories

        ScrollView{
            VStack(spacing: 20) {
                Text("Dashboard")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)

                HStack {

                    VStack {
                        Text("From")
                        DatePicker(
                            "", selection: $selectedStartDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(CompactDatePickerStyle())
                    }
                    .padding()
                    VStack {
                        Text("To")
                        DatePicker(
                            "", selection: $selectedEndDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(CompactDatePickerStyle())
                    }
                    .padding()

                }
                .padding(.horizontal)

                VStack {
                                Text("Average Calories per Day")
                                    .font(.title2)
                                    .foregroundColor(.secondary)

                                Text("\(averageCaloriesPerDay) kcal")
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("lightOrange"))
                            }
                            .padding()
                            .background(Color("lightOrange").opacity(0.1))
                            .cornerRadius(12)

                HStack(spacing: 20) {

                    CalorieCategoryView(
                        category: "Meals",
                        calories: mealCalories,
                        color: colorPick(
                            type: .meal, calories: mealCalories,
                            dailyCalories: averageCaloriesPerDay, targetCalories: 2000),
                        dailyCalories: averageCaloriesPerDay
                    )
                }

                HStack(spacing: 20) {
                    CalorieCategoryView(
                        category: "Sweets",
                        calories: sweetsCalories,
                        color: colorPick(
                            type: .sweet, calories: sweetsCalories,
                            dailyCalories: averageCaloriesPerDay, targetCalories: 2000),
                        dailyCalories: averageCaloriesPerDay
                    )
                    CalorieCategoryView(
                        category: "Fruits",
                        calories: fruitCalories,
                        color: colorPick(
                            type: .fruit, calories: fruitCalories,
                            dailyCalories: averageCaloriesPerDay, targetCalories: 2000),
                        dailyCalories: averageCaloriesPerDay
                    )
                }

                Spacer()
            }
        }
        }

    func filterEntriesByDate(entries: [Entry]) -> [Entry] {
        let calendar = Calendar.current

        let startOfDay = calendar.startOfDay(for: selectedStartDate)

        let endOfDay = calendar.date(
            bySettingHour: 23, minute: 59, second: 59, of: selectedEndDate)!

        return entries.filter { entry in
            entry.date >= startOfDay && entry.date <= endOfDay
        }
    }

    // Helper function to calculate the number of days between two dates
    func calculateNumberOfDays(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current

        // Calculate the number of days between the start and end dates
        let dateComponents = calendar.dateComponents(
            [.day], from: startDate, to: endDate)

        // Add 1 to include the start date in the range
        return (dateComponents.day ?? 0) + 1
    }
}

func addCalories(entries: [Entry]) -> Int {
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
        meals: .constant(MOCKUP_mealEntries),

        sweets: .constant(MOCKUP_sweetsEntries),

        fruits: .constant(MOCKUP_fruitEntries)
    )
}
