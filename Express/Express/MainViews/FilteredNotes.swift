//
//  FilteredNotes.swift
//  Express
//
//  Created by Alessandro Rippa on 10/12/24.
//

import CoreData
import SwiftUI

struct FilteredNotes: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc

    
    var body: some View {
        
        List{
            
            ForEach(fetchRequest){ note in
                
                VStack(alignment: .leading){
                    
                    Text(note.wrappedTitle)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(note.wrappedBody)
                    HStack{
                        Spacer()
                        Text(note.wrappedDate.formatted(.dateTime))
                            .fontWeight(.semibold)
                    }
                    
                }.padding(10)
                
            }.onDelete(perform: deleteNote)
            
            
            
            
        }.listStyle(PlainListStyle())
        
    }
    
    init (filter: Date){
        _fetchRequest = FetchRequest<Note>(sortDescriptors: [], predicate: NSPredicate(format: "date <= %@", filter as CVarArg), animation: .bouncy)
    }
    
    func deleteNote(at offsets: IndexSet){
        for offset in offsets {
            let note = fetchRequest[offset]
            moc.delete(note)
            try? moc.save()
        }
    }

}


#Preview {
    FilteredNotes(filter: Date())
}

