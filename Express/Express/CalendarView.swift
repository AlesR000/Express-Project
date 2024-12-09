//
//  CalendarView.swift
//  Express
//
//  Created by Alessandro Rippa on 03/12/24.
//

import SwiftUI

struct CalendarView: View {
    //MARK: PROPERTIES
    let currentWeek = Calendar.current.component(.weekOfYear, from: Date.now)
    
    //MARK: BODY
    var body: some View {
        
            //Text(Date.now, format: .dateTime.hour().minute())
            
        VStack{
            
            Text(Date.now, format: .dateTime.weekday())
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.indigo)
                //Text(Date.now, format: .dateTime.week())
                //    .font(.largeTitle)
            
            Text(Date.now.formatted(date: .long, time: .shortened))
                .font(.largeTitle)
                .foregroundColor(Color.blue)
                .padding(.horizontal)
            
        }
        .background(.white)
        .containerShape(RoundedRectangle(cornerRadius:40))
        
    }
    
    /*
     
    func trivialExample() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minutes = components.minute ?? 0
        
    }
    */
    
}

struct currentDay {
    
}

#Preview {
    CalendarView()
}
