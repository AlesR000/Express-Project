//
//  Home.swift
//  Express
//
//  Created by Alessandro Rippa on 12/12/24.
//

import SwiftUI

struct Home: View {
    
    //MARK: Properties
    @State var showNote: Bool = false
    @State var showWritingScreen: Bool = false
    @State var selectedDay: Date?
    @State var selectedNote: Note?
    @State var showEdit: Bool = false
    
    @Environment(\.managedObjectContext) var moc
    
    //MARK: Body
    var body: some View {
        
        CalendarWeekView(selectedDay: $selectedDay)
            .background(Color.blue)
        
        
        Button{
            showWritingScreen = true
        }
        label:{
            
            HStack{
                Spacer()
                Text("Express your day")
                    .foregroundStyle(.black)
                    .padding()
                    .background(.yellow)
                    .containerShape(Capsule())
                Spacer()
                
            }
            .padding()
            .accessibilityLabel("add note")
            .accessibilityHint("Press to enter a note")
        }
        .sheet(isPresented: $showWritingScreen){
            WriteNote(showModal: $showWritingScreen)
        }
        
        
        FilteredNotes(filter: selectedDay ?? Date(), selectedNote: $selectedNote, showNote: $showNote, selectedDate: $selectedDay, showEdit: $showEdit)
            .sheet(isPresented: $showNote){
                if let selectedNote = selectedNote {
                    NoteView(note: selectedNote)
                }
            }
         
    }
}

#Preview {
    Home()
}
