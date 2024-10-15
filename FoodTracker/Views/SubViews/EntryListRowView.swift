//
//  EntryListSectionView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import SwiftUI

struct EntryListRowView: View {
    var maxCal: Int
    @Binding var entry: Entry
    @Binding var selectedEntry: Entry?
    @Binding var showDetailSheet: Bool

    var body: some View {
        Button {
            selectedEntry = entry
            showDetailSheet = true
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.title)
                        .font(.headline)
                        .foregroundColor(
                            entry.calories < maxCal
                                ? Color("mint") : Color("lightred")
                        )
                        .lineLimit(1)
                        .truncationMode(.tail)
                    

                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(
                                entry.calories < maxCal
                                    ? Color("mint") : Color("lightred")
                            )
                        Spacer().frame(width: 4)
                        Text("\(entry.calories) Kalorien (amount: \(entry.quantity), \(entry.servingSize))")
                            .font(.subheadline)
                            .foregroundColor(
                                entry.calories < maxCal
                                    ? Color("mint") : Color("lightred")
                            )
                    }
                    .padding(.top, 2)
                    
                    HStack {
                        Image(systemName: "clock")
                        Text(entry.mealTime.rawValue.capitalized)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(entry.date.formatted())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    switch entry.type {
                    case .meal: Image(systemName: "fork.knife")
                            .foregroundColor(.gray)
                    case .drink: Image(systemName: "cup.and.saucer.fill")
                            .foregroundColor(.gray)
                    case .sweet: Image(systemName: "birthday.cake.fill")
                            .foregroundColor(.gray)
                    case .fruit: Image(systemName: "applelogo")
                            .foregroundColor(.gray)
                    }

                    switch entry.healthRating {
                    case .green:
                        Image(systemName: "leaf.fill").foregroundColor(.green)
                    case .yellow:
                        Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow)
                    case .red:
                        Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                    }
                }
            }
            .frame(height: 100)
            .padding(12)
            .background(
                entry.calories < maxCal
                    ? Color("mint").opacity(0.1)
                    : Color("lightred").opacity(0.1)
            )
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        entry.calories < maxCal
                            ? Color("mint") : Color("lightred"),
                        lineWidth: 1
                    )
            )
        }
        .sheet(isPresented: $showDetailSheet) {
            if let entry = selectedEntry {
                ZStack {
                    Color(entry.calories < maxCal
                          ? Color("mint") : Color("lightred")).opacity(0.1).edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Spacer()
                        Text(entry.title)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Spacer()
                        
                        VStack(spacing: 10) {
                            Label("\(entry.calories) calories", systemImage: "flame.fill")
                                .font(.title2)
                                .foregroundColor(.orange)
                            
                            Label(entry.date.formatted(date: .long, time: .shortened), systemImage: "calendar")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Label("amount: \(entry.quantity), \(entry.servingSize)", systemImage: "bag.fill")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Text("Health Rating:")
                                switch entry.healthRating {
                                case .green: Text("Good").foregroundColor(.green)
                                case .yellow: Text("Moderate").foregroundColor(.yellow)
                                case .red: Text("Unhealthy").foregroundColor(.red)
                                }
                            }
                            
                            Label(entry.mealTime.rawValue.capitalized, systemImage: "clock")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        
                        Spacer()
                    }
                    .padding()
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}
#Preview {
    EntryListRowView(
        maxCal: 2000,
        entry: .constant(
            Entry(
                id: "2", title: "Banana", date: Date(), calories: 105,
                type: .fruit)),selectedEntry: .constant(
                    Entry(
                        id: "2", title: "Banana", date: Date(), calories: 105,
                        type: .fruit)), showDetailSheet: .constant(true))
}
