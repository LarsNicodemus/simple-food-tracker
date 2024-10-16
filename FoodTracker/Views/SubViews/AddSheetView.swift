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
    @Binding var drinkEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
    
    @State private var showError = false

    var body: some View {
        Button("Neuer Eintrag") {
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
                            TextField("Hier eingeben...", text: $titleTextInput)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Typ") {
                            Picker("Typ auswählen", selection: $types) {
                                ForEach(category.allCases, id: \.self) { type in
                                    Text(type.rawValue.capitalized).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section("Kalorien") {
                            TextField("Kalorienzahl", text: $caloriesTextInput)
                                .keyboardType(.numberPad)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Portionsgröße") {
                            TextField("Portionsgröße", text: $servingSizeInput)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Menge") {
                            TextField("Menge", text: $quantityInput)
                                .keyboardType(.numberPad)
                                .foregroundColor(Color("minti"))
                        }
                        
                        Section("Health Rating") {
                            Picker("Bewertung", selection: $healthRating) {
                                Text("Grün").tag(HealthRating.green)
                                Text("Gelb").tag(HealthRating.yellow)
                                Text("Rot").tag(HealthRating.red)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section("Mahlzeit") {
                            Picker("Mahlzeit", selection: $mealTime) {
                                ForEach(MealTime.allCases, id: \.self) { time in
                                    Text(time.rawValue.capitalized).tag(time)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Section("Datum & Uhrzeit"){
                            DatePicker(
                                            "Datum auswählen",
                                            selection: $selectedDate,
                                            displayedComponents: [.date, .hourAndMinute]
                                        )
//                            Text("Ausgewähltes Datum: \((selectedDate).formatted())")
                        }
                    }
                    Spacer().frame(height: 16)
                    
                    Button("Eintrag speichern") {
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
                            case .drink:
                                drinkEntries.append(newEntry)
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
                        Alert(title: Text("Fehler"), message: Text("Bitte alle Felder korrekt ausfüllen"), dismissButton: .default(Text("OK")))
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

#Preview {

    AddSheetView(
        showSheet: .constant(true), titleTextInput: "Banane", caloriesTextInput: "123",
        mealEntries: .constant([
            Entry(
                id: "2", title: "Banana", date: Date(), calories: 105,
                type: .fruit)
        ]),
        drinkEntries: .constant([
            Entry(
                id: "2", title: "Banana", date: Date(), calories: 105,
                type: .fruit)
        ]),
        sweetsEntries: .constant([
            Entry(
                id: "2", title: "Banana", date: Date(), calories: 105,
                type: .fruit)
        ]),
        fruitEntries: .constant([
            Entry(
                id: "2", title: "Banana", date: Date(), calories: 105,
                type: .fruit)
        ])
    )
}
