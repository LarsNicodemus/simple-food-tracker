//
//  EntryListSectionView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import SwiftUI

struct EntryListSectionView: View {
    let maxCal: Int
    let sectionTitle: String
    @Binding var entries: [Entry]
    var body: some View {
        Section(sectionTitle){
        ForEach($entries) { $entry in
            EntryListRowView(maxCal: maxCal, entry: $entry)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    if let index = entries.firstIndex(where: { $0.id == entry.id }) {
                        entries.remove(at: index)
                    }
                    
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                
            }
        }
        
        .padding(.vertical, 4)}
    }
}

#Preview {
    EntryListSectionView(maxCal: 2000, sectionTitle: "Meals", entries: .constant([Entry(id: "1", title: "Tuna Maki Sushi", date: Date(), calories: 173),
                                                                                  Entry(id: "2", title: "Chicken Caesar Salad", date: Date(), calories: 350),
                                                                                  Entry(id: "3", title: "Vegetable Lasagna", date: Date(), calories: 420),
                                                                                  Entry(id: "4", title: "Grilled Salmon with Asparagus", date: Date(), calories: 380)]))
}
