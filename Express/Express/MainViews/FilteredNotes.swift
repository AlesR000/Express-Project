//
//  FilteredNotes.swift
//  Express
//
//  Created by Alessandro Rippa on 10/12/24.
//

import CoreData
import SwiftUI

struct FilteredNotes: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: false)], animation: .default) var fetchRequest: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc
    @Binding var selectedNote: Note?
    @Binding var showNote: Bool
    
    let emojis: [String] = ["TerribleEmoji", "SadEmoji", "NeutralEmoji", "HappyEmoji", "AmazingEmoji"]
    
    var body: some View {
        
        List{
            
            ForEach(fetchRequest){ note in
                
                Button{
                    
                    selectedNote = note
                    showNote = true
                    
                }label:{
                    
                    VStack(alignment: .leading){
                        
                        HStack(){
                            
                            Text(note.wrappedTitle)
                                .font(.title2)
                                //.fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(emojis[Int(note.mood) - 1])
                                .resizable()
                                .scaledToFit()
                                .frame(height:40)
                             
                        }
                        
                        Text(note.wrappedBody)
                            .fontWeight(.light)
                        
                        HStack{
                            
                            Spacer()
                            Text(note.wrappedDate.formatted(.dateTime))
                                .fontWeight(.light)
                                .padding(.top, 5)
                                
                        }
                        
                    }
                    
                }
                
            }
            .onDelete(perform: deleteNote)
        }
        .listStyle(PlainListStyle())
    }
    
    init (filter: Date, selectedNote: Binding<Note?>, showNote: Binding<Bool>){
        
        _fetchRequest = FetchRequest<Note>(sortDescriptors: [], predicate: NSPredicate(format: "date <= %@", filter as CVarArg), animation: .bouncy)
        _selectedNote = selectedNote
        _showNote = showNote
        
    }
    
    func deleteNote(at offsets: IndexSet){
        
        for offset in offsets {
            
            let note = fetchRequest[offset]
            moc.delete(note)
            try? moc.save()
            
        }
        
    }

}

/*
#Preview {
    FilteredNotes(filter: Date())
}
*/