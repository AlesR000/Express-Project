//
//  Home.swift
//  Express
//
//  Created by Alessandro Rippa on 10/12/24.
//

import SwiftUI

struct Home: View {
    //MARK: Properties
    @State var showNote: Bool = false
    @State var showWritingScreen: Bool = false
    @State var selectedDay: Date?
    
    @Environment(\.managedObjectContext) var moc
    
    //MARK: Body
    var body: some View {
        
        CalendarWeekView(selectedDay: $selectedDay)
        
        
        Button{
            showWritingScreen = true
        }
        label:{
            HStack{
                Spacer()
                Text("Express your day")
                Image("AddButton")
                    .resizable()
                    .frame(width: 50,height: 50)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showWritingScreen){
            WriteNote(showModal: $showWritingScreen)
        }
        
        FilteredNotes(filter: selectedDay ?? Date())
        
    }
}

#Preview {
    Home()
}
