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
    @Binding var mealEntries: [Entry]
    @Binding var drinkEntries: [Entry]
    @Binding var sweetsEntries: [Entry]
    @Binding var fruitEntries: [Entry]
    @State private var types: category = .meal
    var body: some View {
        Button("new Entry") {
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
                
                VStack{
                    Form {
                        Section("name") {
                            TextField("type here..", text: $titleTextInput)
                                .foregroundStyle(Color("mint"))
                                
                        }
                        Section("type") {
                            Picker("Select a Type", selection: $types) {
                                ForEach(category.allCases) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)

                        }
                        Section("calories") {
                            TextField("type here..", text: $caloriesTextInput)
                                .foregroundStyle(Color("mint"))
                        }
                        
                    }
                    Spacer().frame(height: 16)
                    Button("Save entry"){
                        switch types {
                        case .meal: mealEntries.append(Entry(id: String(mealEntries.count + 1), title: titleTextInput, calories: Int(caloriesTextInput) ?? 0, type: types))
                        case .drink: drinkEntries.append(Entry(id: String(mealEntries.count + 1), title: titleTextInput, calories: Int(caloriesTextInput) ?? 0, type: types))
                        case .sweet: sweetsEntries.append(Entry(id: String(mealEntries.count + 1), title: titleTextInput, calories: Int(caloriesTextInput) ?? 0, type: types))
                        case .fruit: fruitEntries.append(Entry(id: String(mealEntries.count + 1), title: titleTextInput, calories: Int(caloriesTextInput) ?? 0, type: types))
                        }
                        showSheet = false
                    }
                }
                
                
            }
            .presentationDetents([.medium, .large])
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
