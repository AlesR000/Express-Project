//
//  CalendarWeekView.swift
//  Express
//
//  Created by Alessandro Rippa on 10/12/24.
//

import SwiftUI

struct CalendarWeekView: View {
    
    @State private var currentWeekStart: Date = getStartOfCurrentWeek()
    
    var currentDay = Date()
    @Binding var selectedDay: Date?
    
    var body: some View {
        
        
        VStack {
            
            HStack {
                Button(action: {
                    currentWeekStart = previousWeek(from: currentWeekStart)
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                
                Text(formatWeekRange(from: currentWeekStart))
                    .padding()
                    .font(.title2)
                    .lineLimit(1)
                
                Spacer()
                
                Button(action: {
                    currentWeekStart = nextWeek(from: currentWeekStart)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            
            
            let days = daysInWeek(startingFrom: currentWeekStart)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { day in
                    
                    VStack{
                        Text(day, format: .dateTime.weekday())
                        
                        ZStack {
                            
                            Text(day, format: .dateTime.day())
                                .frame(maxWidth: .infinity)
                                .background(Circle().fill(Color.mint))
                        }
                    }
                    .onTapGesture {
                        selectedDay = day + 86400
                    }
                    
                }
                
            }
        }
        .padding()
    }
    
    
    //MARK: Functions
    
    // Get the start date of the current week
    private static func getStartOfCurrentWeek() -> Date {
        let calendar = Calendar.current
        let now = Date()
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
    }
    
    private func nextWeek(from date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .weekOfYear, value: 1, to: date)!
    }
    
    private func previousWeek(from date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .weekOfYear, value: -1, to: date)!
    }
    
    private func daysInWeek(startingFrom date: Date) -> [Date] {
        let calendar = Calendar.current
        var days: [Date] = []
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                days.append(day)
            }
        }
        
        return days
    }
    
    // Format the week range (e.g., "Dec 8, 2024 - Dec 14, 2024")
    private func formatWeekRange(from date: Date) -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let startString = formatter.string(from: startOfWeek)
        let endString = formatter.string(from: endOfWeek)
        
        return "\(startString) - \(endString)"
    }
}

    //MARK: Preview
/*
#Preview {
    CalendarWeekView()
}
*/
