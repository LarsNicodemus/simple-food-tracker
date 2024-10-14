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

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.title)
                Text("\(entry.calories) Kalorien")
                    .font(.subheadline)
                    .foregroundColor(
                        entry.calories < maxCal
                            ? Color("mint") : Color("lightred"))
            }
            Spacer()
            Text("\(entry.date.formatted())")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(height: 66)
        .padding(8)
        .background(
            entry.calories < maxCal
                ? Color("mint").opacity(0.1)
                : Color("lightred").opacity(0.1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    entry.calories < maxCal
                        ? Color("mint") : Color("lightred"),
                    lineWidth: 1)
        )

    }
}

#Preview {
    EntryListRowView(maxCal: 2000, entry: .constant(Entry(id: "2", title: "Banana", date: Date(), calories: 105)))
}
