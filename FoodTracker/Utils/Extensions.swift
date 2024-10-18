//
//  Extensions.swift
//  FoodTracker
//
//  Created by Lars Nicodemus on 18.10.24.
//

import Foundation

extension Date {
    static func time(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int = 0) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return calendar.date(from: dateComponents) ?? Date()
    }
    static func day(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
    }
}

