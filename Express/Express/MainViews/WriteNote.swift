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
    
    @State private var title: String = ""
    @State private var noteBody: String = ""
    @State private var mood: Int16 = 3
    
    let moods: [String] = ["amazing", "happy", "neutral", "sad", "terrible"]
    let emojis: [String] = ["AmazingEmoji", "HappyEmoji", "NeutralEmoji", "SadEmoji", "TerribleEmoji"]
    
    var body: some View {
        
        
        
        VStack{
            HStack{
                
                Spacer()
                
                Button("Add"){
                    let note = Note(context: moc)
                    note.title = title
                    note.body = noteBody
                    note.mood = mood
                    note.date = Date.now
                    
                    try? moc.save()
                    showModal.toggle()
                }
                .foregroundStyle(.red)
                
            }.padding()
            
            Text ("how are you feeling today?")
                .font(.headline)
            
            HStack{
                ForEach(1..<6){ index in
                    VStack{
                        Image(emojis[index-1])
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        
                        Text(moods[index-1])
                            .font(.footnote)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(10)
                    .onTapGesture { mood = Int16(6-index) }
                    
                }
                
            }
            
        }
        .padding(.vertical)
        .background(Color.blue.opacity(0.5))

        
        List{
            TextField("Title", text: $title)
                .padding()
            
            TextField("write a note", text: $noteBody, axis: .vertical)
                .frame(maxHeight: .infinity)
                .padding()
        
        }.listStyle(PlainListStyle())
        
        
    }
    
}

#Preview {
    WriteNote(showModal: .constant(true))
}
