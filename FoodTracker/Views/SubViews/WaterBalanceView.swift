//
//  WaterBalanceView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 17.10.24.
//

import SwiftUI
import Charts


struct WaterBalanceView: View {
    //    @Binding var path: NavigationPath
    var dailyDrinks: DailyDrinks
    @State var dateOption: DateChoice = .day
    @State private var selectedPeriod = 0
    @State private var hydrationAmount = 1700

    let periods = ["Daily", "Weekly", "Monthly"]
    var body: some View {
        //
        //        VStack(spacing: 20) {
        //                    HStack(spacing: 10) {
        //                        ForEach(DateChoice.allCases, id: \.self) { choice in
        //                            Button(action: {
        //                                dateOption = choice
        //                            }) {
        //                                Text(choice.rawValue)
        //                                    .frame(width: 70)
        //                                    .padding()
        //                                    .foregroundColor(dateOption == choice ? .white : .black)
        //                                    .background(dateOption == choice ? Color("minti") : Color("lightOrange").opacity(0.2))
        //                                    .cornerRadius(10)
        //                            }
        //                        }
        //                    }
        //                    .padding()
        //            HydrationChart()
        //            WaterConsumptionRow(time: "TestZeit", amount: 300)
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

                Text(
                    "Humans need to consume about 2000 ml of water daily to stay properly hydrated."
                )
                .padding()
                .background(Color("turquoise").opacity(0.2))
                .cornerRadius(10)

                HStack {
                    Image(systemName: "drop.fill")
                        .foregroundColor(Color("turquoise"))
                    Text("Hydrate")
                    Spacer()
                    Text("\(hydrationAmount) ML")
                        .font(.title)
                        .bold()
                }

                HydrationChart()

                WaterConsumptionRow(time: "2:40 PM", amount: 750)

                Button(action: {
                }) {
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
            .navigationTitle("Water Balance")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {}) {
                    Image(systemName: "chevron.left")
                },
                trailing: Button(action: {}) {
                    Image(systemName: "ellipsis")
                })
        }
    }
}

struct TestDrink: Identifiable, Hashable {
    var id: UUID = UUID()
    var time: Date = Date()
    var percentage: Int = 0
    
}
extension Date {
    static func time(hour: Int, minute: Int, second: Int = 0) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return calendar.date(from: dateComponents) ?? Date()
    }
}

struct HydrationChart: View {

    
    let testdrinks = [
        TestDrink(time: Date.time(hour: 6, minute: 00), percentage: 100),
        TestDrink(time: Date.time(hour: 10, minute: 00), percentage: 80),
        TestDrink(time: Date.time(hour: 14, minute: 00), percentage: 60),
        TestDrink(time: Date.time(hour: 18, minute: 00), percentage: 40),
        TestDrink(time: Date.time(hour: 22, minute: 00), percentage: 20),
        TestDrink(time: Date.time(hour: 23, minute: 00), percentage: 0)
        
    ]
    let percentages = [100, 80, 60, 40, 20, 0]
    
    var body: some View {
        
        HStack{
//            HStack{
//                VStack(alignment: .trailing, spacing: 0) {
//                    ForEach(percentages, id: \.self) { percent in
//                        Text("\(percent)%")
//                            .font(.caption)
//                            .frame(height: 55)
//                    }
//                }
//                .padding(.trailing, 4)
//               
//            }
//            .frame(height: 320)
            ScrollView(.horizontal){
                Chart{
                    ForEach(testdrinks){drink in
                                BarMark(
                                    x: .value("Produkt", drink.time),
                                    y: .value("Preis", drink.percentage)
                                    
                                    
                                )
                            }
                        }
                .chartYScale(domain: 0...100)
                .chartXScale(domain: 0...300)
                
            }
            
            .frame(height: 320)
        }

        
        
        
        
    }
    
}

struct WaterConsumptionRow: View {
    let time: String
    let amount: Int

    var body: some View {
        HStack {
            Image(systemName: "waterbottle.fill")
            Text("Water Consumption")
            Spacer()
            VStack(alignment: .trailing) {
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(amount)ML")
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    WaterBalanceView(dailyDrinks: DailyDrinks(consumedDrinks: [Drink()]))
}
