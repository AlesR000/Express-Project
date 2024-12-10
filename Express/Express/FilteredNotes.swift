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
    
    
    var body: some View {
        
        List(fetchRequest, id: \.self) { note in
            
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
            
            
        }.listStyle(PlainListStyle())
        
    }
    
    init (filter: Date){
        _fetchRequest = FetchRequest<Note>(sortDescriptors: [], predicate: NSPredicate(format: "date <= %@", filter as CVarArg), animation: .bouncy)
    }
    

}


#Preview {
    FilteredNotes(filter: Date())
}

