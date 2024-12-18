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
        
        
        VStack(spacing: 30) {
            
            HStack {
                Button(action: {
                    currentWeekStart = previousWeek(from: currentWeekStart)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .accessibilityLabel("previous")
                        .accessibilityHint("Press to go to the previous week")
                }
                Spacer()
                
                Text(formatWeekRange(from: currentWeekStart))
                    .font(.title2)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                
                Spacer()
                
                Button(action: {
                    currentWeekStart = nextWeek(from: currentWeekStart)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                        .accessibilityLabel("next")
                        .accessibilityHint("Press to go to the next week")
                }
            }
            
            
            let days = daysInWeek(startingFrom: currentWeekStart)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { day in
                    
                    
                    let isSelected = isTheSameDay(firstDate: day, secondDate: selectedDay?.addingTimeInterval( -86400) ?? .distantFuture)
                    
                    VStack(spacing: 10){
                        
                        Text(day, format: .dateTime.weekday(.short))
                            .foregroundStyle(isSelected ? .red : .blue)
                            //.foregroundStyle(.blue)
                            .fontWeight(.bold)
                            
                        Text(day, format: .dateTime.day())
                            .foregroundStyle(isSelected ? .red : .primary)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.thickMaterial))
                    .onTapGesture {selectedDay = day + 86400}
                    .accessibilityLabel(day.formatted())
                    .accessibilityHint("tap to search for notes written this day")
                    
                }
                
            }
        }
        .padding()
    }
    
    
    //MARK: Functions
    
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
    
    private func specificDay(date: Date) -> Text {
        return Text(date.formatted(date: .complete, time: .omitted))
    }
    
    private func isTheSameDay(firstDate: Date, secondDate: Date) -> Bool {
        let firstDay = specificDay(date: firstDate)
        let secondDay = specificDay(date: secondDate)
        
        return firstDay == secondDay
    }
    
}

    //MARK: Preview
/*
#Preview {
    CalendarWeekView()
}
*/
