//
//  AddSheetView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 15.10.24.
//

import SwiftUI

struct AddSheetView: View {
    @Binding var showSheet: Bool
    @State var titleTextInput: String = ""
    @State var caloriesTextInput: String = ""
    @State var servingSizeInput: String = "1 Portion"
    @State var quantityInput: String = "1"
    @State private var selectedDate: Date = Date()
    @State private var types: category = .meal
    @State private var healthRating: HealthRating = .green
    @State private var mealTime: MealTime = .lunch

    @Binding var mealEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
    
    @State private var showError = false

    var body: some View {
        Button("New Entry") {
            showSheet = true
        }
        .padding()
        .foregroundColor(.white).bold()
        .background(Color(Color("lightOrange")).opacity(0.8))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("lightOrange"), lineWidth: 1)
        )
        .sheet(isPresented: $showSheet) {
            ZStack {
                VStack {
                    Form {
                        Section("Name") {
                            TextField("Enter here...", text: $titleTextInput)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Type") {
                            Picker("select type", selection: $types) {
                                ForEach(category.allCases, id: \.self) { type in
                                    Text(type.rawValue.capitalized).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section("Calories") {
                            TextField("Caloriescount", text: $caloriesTextInput)
                                .keyboardType(.numberPad)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Portionsize") {
                            TextField("Portionsize", text: $servingSizeInput)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Amount") {
                            TextField("Amount", text: $quantityInput)
                                .keyboardType(.numberPad)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Health Rating") {
                            Picker("Rating", selection: $healthRating) {
                                Text("Green").tag(HealthRating.green)
                                Text("Yellow").tag(HealthRating.yellow)
                                Text("Red").tag(HealthRating.red)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section("Meal") {
                            Picker("Meal", selection: $mealTime) {
                                ForEach(MealTime.allCases, id: \.self) { time in
                                    Text(time.rawValue.capitalized).tag(time)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Section("Date & Time"){
                            DatePicker(
                                            "Select",
                                            selection: $selectedDate,
                                            displayedComponents: [.date, .hourAndMinute]
                                        )
//                            Text("Ausgewähltes Datum: \((selectedDate).formatted())")
                        }
                    }
                    Spacer().frame(height: 16)
                    
                    Button("Save Entry") {
                        if let calories = Int(caloriesTextInput),
                           let quantity = Int(quantityInput),
                           !titleTextInput.isEmpty {
                            let newEntry = Entry(
                                id: UUID().uuidString,
                                title: titleTextInput,
                                date: selectedDate,
                                calories: calories,
                                type: types,
                                servingSize: servingSizeInput,
                                quantity: quantity,
                                healthRating: healthRating,
                                mealTime: mealTime
                            )
                            
                            switch types {
                            case .meal:
                                mealEntries.append(newEntry)
                            case .sweet:
                                sweetsEntries.append(newEntry)
                            case .fruit:
                                fruitEntries.append(newEntry)
                            }
                            showSheet = false
                        } else {
                            showError = true
                        }
                    }
                    .alert(isPresented: $showError) {
                        Alert(title: Text("Error"), message: Text("Please fill in all Forms"), dismissButton: .default(Text("OK")))
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}



struct AddSheetViewTwo: View {
    @Binding var showSheet: Bool
    @State private var selectedTab = 0
    @State var titleTextInput: String = ""
    @State var caloriesTextInput: String = ""
    @State var servingSizeInput: String = "1 Portion"
    @State var quantityInput: String = "1"
    @State private var selectedDate: Date = Date()
    @State private var selectedDateTwo: Date = Date()
    @State private var types: category = .meal
    @State private var healthRating: HealthRating = .green
    @State private var mealTime: MealTime = .lunch
    @State var selectedDrink: DrinkCategory = .water
    @State var selectedQuantity: String = ""
    @Binding var dailyDrinks: DailyDrinks
    @Binding var mealEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
    
    @State private var showError = false
    
    var body: some View {
        Button("New Entry") {
            showSheet = true
        }
        .padding()
        .foregroundColor(.white).bold()
        .background(Color(Color("lightOrange")).opacity(0.8))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("lightOrange"), lineWidth: 1)
        )
        .sheet(isPresented: $showSheet) {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        FirstSheetView(showSheet: $showSheet, titleTextInput: $titleTextInput, caloriesTextInput: $caloriesTextInput, servingSizeInput: $servingSizeInput, quantityInput: $quantityInput, selectedDate: $selectedDate, types: $types, healthRating: $healthRating, mealTime: $mealTime, mealEntries: $mealEntries, sweetsEntries: $sweetsEntries, fruitEntries: $fruitEntries)
                            .tag(0)

                        SecondSheetView(selectedDateTwo: $selectedDateTwo, dailyDrinks: $dailyDrinks, selectedDrink: $selectedDrink, selectedQuantity: $selectedQuantity)
                            .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle())
                    
                    Spacer().frame(height: 16)
                    
                    HStack {
                        if selectedTab == 0 {
                            Button("Save Food Entry") {
                                if let calories = Int(caloriesTextInput),
                                   let quantity = Int(quantityInput),
                                   !titleTextInput.isEmpty {
                                    let newEntry = Entry(
                                        id: UUID().uuidString,
                                        title: titleTextInput,
                                        date: selectedDate,
                                        calories: calories,
                                        type: types,
                                        servingSize: servingSizeInput,
                                        quantity: quantity,
                                        healthRating: healthRating,
                                        mealTime: mealTime
                                    )
                                    
                                    switch types {
                                    case .meal:
                                        mealEntries.append(newEntry)
                                    case .sweet:
                                        sweetsEntries.append(newEntry)
                                    case .fruit:
                                        fruitEntries.append(newEntry)
                                    }
                                    showSheet = false
                                } else {
                                    showError = true
                                }
                            }
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white).bold()
                            .background(Color(Color("lightOrange")).opacity(0.8))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("lightOrange"), lineWidth: 1)
                            )
                            .alert(isPresented: $showError) {
                                Alert(title: Text("Error"), message: Text("Please fill in all forms"), dismissButton: .default(Text("OK")))
                            }
                        } else {
                            Button("Save Hydration Entry") {
                                if let quantity = Int(selectedQuantity),
                                   !selectedQuantity.isEmpty {
                                    let newDrink = Drink(
                                        quantity: quantity, type: selectedDrink, date: selectedDateTwo
                                    )
                                    print(selectedDateTwo)
                                    dailyDrinks.consumedDrinks.append(newDrink)
                                    
                                    
                                    showSheet = false
                                } else {
                                    showError = true
                                }
                            }
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white).bold()
                            .background(Color(Color("lightOrange")).opacity(0.8))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("lightOrange"), lineWidth: 1)
                            )
                        }
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
        
    }
    
}

struct FirstSheetView: View {
    @Binding var showSheet: Bool
    @Binding var titleTextInput: String
    @Binding var caloriesTextInput: String
    @Binding var servingSizeInput: String
    @Binding var quantityInput: String
    @Binding var selectedDate: Date
    @Binding var types: category
    @Binding var healthRating: HealthRating
    @Binding var mealTime: MealTime

    @Binding var mealEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
        var body: some View {
            
            VStack{
                Spacer().frame(height: 20)
                Text("New Food Entry")
                    .font(.headline)
                    .foregroundColor(Color("minti"))
            Form {
                Section("Name") {
                    TextField("Enter name...", text: $titleTextInput)
                        .foregroundColor(Color("minti"))
                }
                
                Section("Type") {
                    Picker("Select type", selection: $types) {
                        ForEach(category.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section("Calories") {
                    TextField("Caloriescount", text: $caloriesTextInput)
                        .keyboardType(.numberPad)
                        .foregroundColor(Color("minti"))
                }
                
                Section("Portionsize") {
                    TextField("Portionsize", text: $servingSizeInput)
                        .foregroundColor(Color("minti"))
                }
                
                Section("Amount") {
                    TextField("Amount", text: $quantityInput)
                        .keyboardType(.numberPad)
                        .foregroundColor(Color("minti"))
                }
                
                Section("Health Rating") {
                    Picker("Rating", selection: $healthRating) {
                        Text("Green").tag(HealthRating.green)
                        Text("Yellow").tag(HealthRating.yellow)
                        Text("Red").tag(HealthRating.red)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section("Meal") {
                    Picker("Meal", selection: $mealTime) {
                        ForEach(MealTime.allCases, id: \.self) { time in
                            Text(time.rawValue.capitalized).tag(time)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section("Date & Time"){
                    DatePicker(
                                    "Select",
                                    selection: $selectedDate,
                                    displayedComponents: [.date, .hourAndMinute]
                                )
                    .environment(\.timeZone, TimeZone.current)
                    
                }
            }
            .tag(0)
        }
    }
}

struct SecondSheetView: View {
    @Binding var selectedDateTwo: Date
    @Binding var dailyDrinks: DailyDrinks
    @Binding var selectedDrink: DrinkCategory
    @Binding var selectedQuantity: String
    var body: some View {
        VStack{
            Spacer().frame(height: 20)
            Text("New Hydration Entry")
                .font(.headline)
                .foregroundColor(Color("minti"))
            Form {
                Section("Amount") {
                    TextField("Insert ML Amount..", text: $selectedQuantity)
                        .keyboardType(.numberPad)
                        .foregroundColor(Color("minti"))
                }
                Section("Drink") {
                    Picker("Select drink", selection: $selectedDrink) {
                        ForEach(DrinkCategory.allCases) { drink in
                            HStack{
                                Image(systemName: drink.symbolName)
                                Spacer()
                                Text(drink.rawValue)
                            }
                            .tag(drink)
                        }
                    }
                    .tint(Color("minti"))
                    .cornerRadius(10)
                    .pickerStyle(.menu)
                    
                }
                Section("Date & Time"){
                    DatePicker(
                                    "Select",
                                    selection: $selectedDateTwo,
                                    displayedComponents: [.date, .hourAndMinute]
                                )
                    .environment(\.timeZone, TimeZone.current)
                }
                
            }
            .tag(1)
        }
    }
}

#Preview {
    @Previewable @State var showSheet: Bool = true
    @Previewable @State var mealEntries: [Entry] = MOCKUP_mealEntries
    @Previewable @State var sweetsEntries: [Entry] = MOCKUP_sweetsEntries
    @Previewable @State var fruitEntries: [Entry] = MOCKUP_fruitEntries
    @Previewable @State var dailyDrinks = MOCKUP_DailyDrinks1
    AddSheetViewTwo(showSheet: $showSheet, dailyDrinks: $dailyDrinks, mealEntries: $mealEntries, sweetsEntries: $sweetsEntries, fruitEntries: $fruitEntries )
//    AddSheetView(showSheet: $showSheet, mealEntries: $mealEntries, sweetsEntries: $sweetsEntries, fruitEntries: $fruitEntries )
    
}
