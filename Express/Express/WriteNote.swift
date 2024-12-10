//
//  WriteNote.swift
//  Express
//
//  Created by Alessandro Rippa on 05/12/24.
//

import SwiftUI

struct WriteNote: View {
    
    @Binding var showModal: Bool
    @Environment(\.managedObjectContext) var moc
    
    @State var title: String = ""
    @State var noteBody: String = ""
    
    @State var mood: String = "neutral"
    
    var body: some View {
        
        
        
        List{
            TextField("Title", text: $title)
                .padding()
            
            TextField("Note", text: $noteBody, axis: .vertical)
                .frame(maxHeight: .infinity)
                .padding()
            
            Picker("Current Mood", selection: $mood){
                Text("amazing")
                Text("happy")
                Text("neutral")
                Text("sad")
                Text("terrible")
            }
        }
        
        Button("save"){
            let note = Note(context: moc)
            note.title = title
            note.body = noteBody
            note.mood = moodToInt(mood: mood)
            note.date = Date.now
            
            try? moc.save()
            showModal.toggle()
        }
        
        
        
    }
    
    func moodToInt(mood: String) -> Int16{
        switch mood{
            case "amazing": return 5
            case "happy": return 4
            case "neutral": return 3
            case "sad": return 2
            case "terrible": return 1
        default:
            return 0
        }
    }
    
    
}

#Preview {
    WriteNote(showModal: .constant(true))
}
