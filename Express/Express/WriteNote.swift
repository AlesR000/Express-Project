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
    
    var body: some View {
        
        
        
        List{
            TextField("Title", text: $title)
                .padding()
            
            TextField("Note", text: $noteBody, axis: .vertical)
                .frame(maxHeight: .infinity)
                .padding()
            
        }
        
        Button("save"){
            let note = Note(context: moc)
            note.title = title
            note.body = noteBody
            note.date = Date.now
            
            try? moc.save()
            showModal.toggle()
        }
        
        
        
    }
}

#Preview {
    WriteNote(showModal: .constant(true))
}
