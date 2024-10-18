//
//  WaterBalanceView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 17.10.24.
//

import Charts
import SwiftUI

struct WaterBalanceView: View {
    @Binding var path: NavigationPath
    @Binding var dailyDrinks: DailyDrinks
    @State var dateOption: DateChoice = .day
    @State private var selectedPeriod = 0
    @State private var hydrationAmount = 0

    let periods = ["Daily", "Weekly", "Monthly"]
    var body: some View {
        let drinksToShow: [Drink] = getDrinksForSelectedPeriod()
        let total = drinksToShow.reduce(0) { $0 + $1.quantity }

        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    ForEach(DateChoice.allCases, id: \.self) { choice in
                        Button(action: {
                            dateOption = choice
                        }) {
                            Text(choice.rawValue)
                                .frame(width: 70)
                                .padding()
                                .foregroundColor(
                                    dateOption == choice ? .white : .black
                                )
                                .background(
                                    dateOption == choice
                                        ? Color("minti")
                                        : Color("lightOrange").opacity(0.2)
                                )
                                .cornerRadius(10)
                        }
                    }
                }
                ScrollView {
                    Text(
                        "Humans need to consume about 2000 ml of water daily to stay properly hydrated."
                    )
                    .padding()
                    .background(Color("turquoise").opacity(0.2))
                    .cornerRadius(10)

                    HStack {
                        if hydrationState(dateOption: dateOption, drinks: drinksToShow, dailyDrinks: dailyDrinks) <= 0 {
                            Label {
                                Text("You`re good")
                                    .font(.headline)
                            } icon: {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(Color("turquoise"))
                            }
                        } else {
                            Label {
                                Text("Keep hydrating")
                                    .font(.headline)
                            } icon: {
                                Image(systemName: "drop.fill")
                                    .foregroundColor(Color("turquoise"))
                            }
                        }
                        Spacer()
                        Text("\(hydrationState(dateOption: dateOption, drinks: drinksToShow, dailyDrinks: dailyDrinks)) ML")
                            .font(.title)
                            .bold()
                    }
                    
                    HydrationChart(dateOption: dateOption, drinks: drinksToShow, dailyDrinks: dailyDrinks)

                    ForEach(drinksToShow) { drink in
                        WaterConsumptionRow(drink: drink)
                    }
                }
                Button {

                } label: {
                    HStack {
                        Text("Add New Hydration")
                        Spacer()
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color("lightOrange"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()

        }
        .navigationTitle("Water Balance")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            trailing: Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "chevron.left")
                }
            }
        }
        .onChange(of: dailyDrinks) { oldValue, newValue in
            hydrationAmount = total
        }
    }
    func getDrinksForSelectedPeriod() -> [Drink] {
        switch dateOption {
        case .day:
            return dailyDrinks.consumedDrinks.filter {
                Calendar.current.isDateInToday($0.date)
            }
        case .week:
            return drinksForCurrentWeek(drinks: dailyDrinks.consumedDrinks)
        case .month:
            return dailyDrinks.consumedDrinks.filter {
                Calendar.current.isDate(
                    $0.date, equalTo: Date(), toGranularity: .month)
            }
        }
    }
    func addDrinkQuantity() {
        for drink in dailyDrinks.consumedDrinks {
            hydrationAmount += drink.quantity
        }
    }
    
}

struct HydrationChart: View {
    let dateOption: DateChoice
    let drinks: [Drink]
    let dailyDrinks: DailyDrinks


    var body: some View {
        VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    Chart {
                        ForEach(getChartData(), id: \.time) { data in
                            BarMark(
                                x: .value("Time", data.time),
                                y: .value("Percentage", data.percentage)
                            )
                            .foregroundStyle(data.percentage > 0 ? Color("turquoise") : Color.gray.opacity(0.3))
                        }
                    }
                    .frame(height: 200)
                    .frame(width: getChartWidth())
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: getAxisCount())) { value in
                            AxisValueLabel {
                                if let time = value.as(String.self) {
                                    Text(time)
                                        .foregroundColor(Color("lightOrange"))
                                }
                            }
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading, values: [0, 25, 50, 75, 100]) { value in
                            AxisGridLine()
                                .foregroundStyle(Color("lightOrange"))
                            AxisTick()
                                .foregroundStyle(Color("lightOrange"))
                            AxisValueLabel {
                                Text("\(value.index * 25)%")
                                    .foregroundColor(Color("lightOrange"))
                            }
                        }
                    }
                    .chartYScale(domain: 0...110)
                }
            }
        .padding()
    }
    
    func getChartData() -> [(time: String, percentage: Double)] {
        switch dateOption {
        case .day:
            return getDailyData()
        case .week:
            return getWeeklyData()
        case .month:
            return getMonthlyData()
        }
    }
    
    func getDailyData() -> [(time: String, percentage: Double)] {
        let hourlyTarget = Double(dailyDrinks.goal) / 24.0
        return (0..<24).map { hour in
            let hourString = String(format: "%02d:00", hour)
            let hourDrinks = drinks.filter { Calendar.current.component(.hour, from: $0.date) == hour }
            let totalQuantity = hourDrinks.reduce(0) { $0 + $1.quantity }
            let percentage = (Double(totalQuantity) / hourlyTarget) * 100
            return (time: hourString, percentage: min(percentage, 100))
        }
    }
    
    func getWeeklyData() -> [(time: String, percentage: Double)] {
        let calendar = Calendar.current
        let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let currentDate = Date()
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        
        return (0..<7).map { dayOffset in
            let day = calendar.date(byAdding: .day, value: dayOffset, to: weekStart)!
            let dayDrinks = drinks.filter { calendar.isDate($0.date, inSameDayAs: day) }
            let totalQuantity = dayDrinks.reduce(0) { $0 + $1.quantity }
            let percentage = Double(totalQuantity) / Double(dailyDrinks.goal) * 100
            return (time: weekdays[dayOffset], percentage: min(percentage, 100))
        }
    }
    
    func getMonthlyData() -> [(time: String, percentage: Double)] {
        let calendar = Calendar.current
        let currentDate = Date()
        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)!.count
        
        return (1...daysInMonth).map { day in
            let date = calendar.date(byAdding: .day, value: day - 1, to: monthStart)!
            let dayDrinks = drinks.filter { calendar.isDate($0.date, inSameDayAs: date) }
            let totalQuantity = dayDrinks.reduce(0) { $0 + $1.quantity }
            let percentage = Double(totalQuantity) / Double(dailyDrinks.goal) * 100
            return (time: "\(day)", percentage: min(percentage, 100))
        }
    }
    
    func getChartWidth() -> CGFloat {
        switch dateOption {
        case .day:
            return 900
        case .week:
            return 400
        case .month:
            return CGFloat(getMonthlyData().count * 20)
        }
    }
    
    func getAxisCount() -> Int {
        switch dateOption {
        case .day:
            return 8
        case .week:
            return 7
        case .month:
            return min(getMonthlyData().count, 10)
        }
    }
}

func hydrationState(dateOption: DateChoice, drinks: [Drink], dailyDrinks: DailyDrinks)-> Int{
    let calendar = Calendar.current
    let currentDate = Date()
    let amountConsumed = drinks.reduce(0) { $0 + $1.quantity }
    switch dateOption {
    case .day:
        return dailyDrinks.goal - amountConsumed
    case .week:
        return (dailyDrinks.goal * 7) - amountConsumed
    case .month:
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 30
        return (dailyDrinks.goal * daysInMonth) - amountConsumed
    }
}

func currentWeekDates() -> (startOfWeek: Date, endOfWeek: Date)? {
    let calendar = Calendar.current
    let today = Date()
    let startOfWeek = calendar.date(
        from: calendar.dateComponents(
            [.yearForWeekOfYear, .weekOfYear], from: today))
    guard let startOfWeek = startOfWeek else { return nil }
    let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
    return (startOfWeek, endOfWeek)
}

func drinksForCurrentWeek(drinks: [Drink]) -> [Drink] {
    guard let week = currentWeekDates() else { return [] }
    return drinks.filter { drink in
        return drink.date >= week.startOfWeek && drink.date <= week.endOfWeek
    }
}

struct WaterConsumptionRow: View {
    let drink: Drink
    var body: some View {
        HStack {
            Image(systemName: drink.type.symbolName)
                .frame(width: 24, height: 24)
            Text(drink.type.rawValue)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(drink.date.formatted())")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(drink.quantity)ML")
                    .font(.headline)
            }
        }
        .foregroundColor(
            drink.type == .beverage
                ? Color("lightred")
                : drink.type == .soda
                    ? Color("lightred")
                    : drink.type == .juice
                        ? Color("lightOrange") : Color("minti")
        )
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    WaterBalanceView(path: $path, dailyDrinks: .constant(MOCKUP_DailyDrinks1))
}
