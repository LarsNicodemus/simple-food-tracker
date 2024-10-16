//
//  EntryListSectionView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import SwiftUI

struct EntryListSectionView: View {
    let title = "Entries"

    let maxCal: Int
    let sectionTitle: String
    @Binding var showDetailSheet: Bool
    @Binding var entries: [Entry]
//    @Binding var selectedEntry: Entry?
    var body: some View {
        
            Section(sectionTitle){
            ForEach($entries) { $entry in
                EntryListRowView(maxCal: maxCal, entry: $entry, showDetailSheet: $showDetailSheet)
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
    EntryListSectionView(maxCal: 2000, sectionTitle: "Meals",showDetailSheet: .constant(false), entries: .constant([Entry(id: "1", title: "Tuna Maki Sushi", date: Date(), calories: 173, type: .meal),
                                                                                  Entry(id: "2", title: "Chicken Caesar Salad", date: Date(), calories: 350, type: .meal),
                                                                                  Entry(id: "3", title: "Vegetable Lasagna", date: Date(), calories: 420, type: .meal),
                                                                                                                    Entry(id: "4", title: "Grilled Salmon with Asparagus", date: Date(), calories: 380, type: .meal)]))
}
