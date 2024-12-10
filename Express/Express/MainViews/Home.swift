//
//  Home.swift
//  Express
//
//  Created by Alessandro Rippa on 10/12/24.
//

import SwiftUI

struct Home: View {
    
    @State var selectedDay: Date?
    
    var body: some View {
        
        CalendarWeekView(selectedDay: $selectedDay)
        
        Button{
            
        } label:{
            
            HStack{
                Spacer()
                Text("Add Note")
                Image("AddButton")
                    .resizable()
                    .frame(width: 50,height: 50)
            }
            .padding(.horizontal)
            
        }
        
        FilteredNotes(filter: selectedDay ?? Date())
        
    }
}

#Preview {
    Home()
}
