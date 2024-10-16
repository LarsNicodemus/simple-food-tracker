//
//  DetailView.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 16.10.24.
//

import SwiftUI

struct DetailView: View {
    var entry: Entry
    var maxCal: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: gradientColors(for: entry.healthRating)),
                               startPoint: .top,
                               endPoint: .bottom)
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text(entry.title)
                        .font(.custom("AvenirNext-Bold", size: 36))
                        .foregroundColor(.primary)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        .padding(.top, 40)
                    Spacer()
                    InfoBox(entry: entry)
                        .frame(height: geometry.size.height * 0.6)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct InfoBox: View {
    var entry: Entry
    
    var body: some View {
        VStack(spacing: 20) {
            InfoRow(icon: "flame.fill", text: "\(entry.calories) calories", color: .orange)
            InfoRow(icon: "calendar", text: entry.date.formatted(date: .long, time: .shortened), color: .blue)
            InfoRow(icon: "bag.fill", text: "amount: \(entry.quantity), \(entry.servingSize)", color: .green)
            
            HStack {
                Text("Health Rating:")
                switch entry.healthRating {
                case .green: Text("Good").foregroundColor(Color("mint"))
                case .yellow: Text("Moderate").foregroundColor(Color("lightOrange"))
                case .red: Text("Unhealthy").foregroundColor(Color("lightred"))
                }
            }
            
            InfoRow(icon: "clock", text: entry.mealTime.rawValue.capitalized, color: .purple)
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.8))
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        )
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
                .frame(width: 40)
            
            Text(text)
                .font(.system(size: 18, weight: .medium, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

func gradientColors(for rating: HealthRating) -> [Color] {
    switch rating {
    case .green:
        return [Color("minti"),Color("mint"),Color("minti"),Color("minti"),Color("lightOrange"), Color("lightred")]
    case .yellow:
        return [Color("minti"),Color("lightOrange"),Color("lightOrange"),Color("lightOrange"),Color("lightOrange"), Color("lightred")]
    case .red:
        return [Color("minti"),Color("lightOrange"), Color("lightred"), Color("lightred"), Color("lightred"),Color("lightred")]
    }
}

#Preview {
    DetailView(entry: Entry(
        id: "2", title: "Banana", date: Date(), calories: 105,
        type: .fruit),maxCal: 2000)
}
