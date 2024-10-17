//
//  EntryListSectionView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 14.10.24.
//

import SwiftUI

struct EntryListSectionView: View {

    let maxCal: Int
    @Binding var showDetailSheet: Bool
    @Binding var entries: [Entry]
    //    @Binding var selectedEntry: Entry?
    var body: some View {

        ForEach($entries) { $entry in
            EntryListRowView(
                maxCal: maxCal, entry: $entry, showDetailSheet: $showDetailSheet
            )
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    if let index = entries.firstIndex(where: {
                        $0.id == entry.id
                    }) {
                        entries.remove(at: index)
                    }

                } label: {
                    Label("Delete", systemImage: "trash")
                }

            }
        }

        .padding(.vertical, 4)

    }
}

#Preview {
    EntryListSectionView(
        maxCal: 2000, showDetailSheet: .constant(false),
        entries: .constant(MOCKUP_mealEntries))
}
