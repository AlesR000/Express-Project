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
    @Binding var selectedDate: Date?
    @Binding var showEdit: Bool
    
    let emojis: [String] = ["TerribleEmoji", "SadEmoji", "NeutralEmoji", "HappyEmoji", "AmazingEmoji"]
    
    var body: some View {
        
        List{
            
            ForEach(fetchRequest.reversed()){ note in
                
                let isSelected = isTheSameDay(firstDate: note.wrappedDate, secondDate: selectedDate?.addingTimeInterval( -86400) ?? .distantFuture)
                
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
                                .foregroundStyle(isSelected ? .red : .primary)
                                .fontWeight(isSelected ? .bold : .light)
                            
                            /*
                            Button {
                                showEdit = true
                            } label: {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.blue)
                            }
                            .sheet(isPresented: $showEdit) {
                                EditView(passedNote: note, showEdit: $showEdit)
                            }
                            */
                             
                        }
                        
                    }
                    
                }
                .accessibilityLabel(note.wrappedTitle)
                .accessibilityHint("Press to open the note, swipe left to delete the note")
                
            }
            .onDelete(perform: deleteNote)
            //.scaleEffect(x: 1, y: -1, anchor: .center)
        }
        //.scaleEffect(x: 1, y: -1, anchor: .center)
        .listStyle(PlainListStyle())
    }
    
    init (filter: Date, selectedNote: Binding<Note?>, showNote: Binding<Bool>, selectedDate: Binding<Date?>, showEdit: Binding<Bool>){
        
        _fetchRequest = FetchRequest<Note>(sortDescriptors: [], predicate: NSPredicate(format: "date <= %@", filter as CVarArg), animation: .bouncy)
        _selectedNote = selectedNote
        _showNote = showNote
        _selectedDate = selectedDate
        _showEdit = showEdit
    }
    
    func deleteNote(at offsets: IndexSet){
        
        for offset in offsets {
            
            let note = fetchRequest[offset]
            moc.delete(note)
            try? moc.save()
            
        }
        
    }

    private func specificDay(date: Date) -> Text {
        return Text(date.formatted(date: .complete, time: .omitted))
    }
    
    private func isTheSameDay(firstDate: Date, secondDate: Date) -> Bool {
        let firstDay = specificDay(date: firstDate)
        let secondDay = specificDay(date: secondDate)
        
        return firstDay == secondDay
    }
    
    
}

/*
#Preview {
    FilteredNotes(filter: Date())
}
*/
