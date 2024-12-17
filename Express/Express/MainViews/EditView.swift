//
//  EditView.swift
//  Express
//
//  Created by Alessandro Rippa on 17/12/24.
//

import SwiftUI

struct EditView: View {
    
    @State var passedNote: Note
    @Binding var showEdit: Bool
    @Environment(\.managedObjectContext) var moc
    
    @State private var title: String
    @State private var noteBody: String
    @State private var mood: Int16
    
    let moods: [String] = ["terrible", "sad", "neutral", "happy", "amazing"]
    let emojis: [String] = ["TerribleEmoji", "SadEmoji", "NeutralEmoji", "HappyEmoji", "AmazingEmoji"]
    
    var body: some View {
        
        VStack{
            HStack{
                
                Spacer()
                
                Button("Edit"){
                    let note = Note(context: moc)
                    note.title = title
                    note.body = noteBody
                    note.mood = passedNote.mood
                    note.date = passedNote.date
                    note.image = passedNote.image
                    note.recording = passedNote.recording
                    
                    moc.delete(passedNote)
                    try? moc.save()
                    showEdit.toggle()
                    
                    
                }
                .foregroundStyle(.red)
                .padding(5)
                .background(Color.white)
                .containerShape(RoundedRectangle(cornerRadius: 10))
                
                
            }.padding()
            
            
            
            HStack{
                
                Text ("You were feeling...")
                    .foregroundStyle(.white)
                    .font(.headline)
                
                    VStack{
                        Image(emojis[Int(passedNote.mood) - 1])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        
                        Text(moods[Int(passedNote.mood)-1])
                            .foregroundStyle(.white)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                }
                  
            }
            .padding()
            
        }
        .padding(.vertical)
        .background(Color.blue)
        
        List{
            TextField("Title", text: $title)
                .padding()
            /*
                .accessibilityLabel("Title") TITOLO
                .accessibilityHint("Enter a title") DESCRIZIONE
            */
            
            TextField("write a note", text: $noteBody, axis: .vertical)
                .frame(maxHeight: .infinity)
                .padding()
        
        }
        .listStyle(PlainListStyle())
    }
    
    
    init(passedNote : Note, showEdit: Binding<Bool>) {
        _title = State(initialValue: passedNote.wrappedTitle)
        _noteBody = State(initialValue: passedNote.wrappedBody)
        _mood = State(initialValue: passedNote.mood)
        _showEdit = showEdit
        _passedNote = State(initialValue: passedNote)
    }
    
}
/*
#Preview {
    EditView()
}
*/
