//
//  WriteNote.swift
//  Express
//
//  Created by Alessandro Rippa on 05/12/24.
//

import SwiftUI
import PhotosUI

struct WriteNote: View {
    
    @Binding var showModal: Bool
    @Environment(\.managedObjectContext) var moc
    
    @State private var title: String = ""
    @State private var noteBody: String = ""
    @State private var mood: Int16 = 3
    @State var selectedEmoji: Int = 0
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State var recordedAudio: Data?
    
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
                    note.image = selectedPhotoData
                    note.recording = recordedAudio
                    
                    try? moc.save()
                    showModal.toggle()
                    
                    
                }
                .foregroundStyle(.red)
                .padding(5)
                .background(Color.white)
                .containerShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityLabel("Save note")
                .accessibilityHint("Press to save your note")
                
                
            }.padding()
            
            Text ("how are you feeling today?")
                .foregroundStyle(.white)
                .font(.headline)
            
            HStack{
                ForEach(1..<6){ index in
                    VStack{
                        Image(emojis[index-1])
                            .resizable()
                            .scaledToFit()
                            .grayscale(selectedEmoji == index ? 0 : 1.0)
                            .frame(maxWidth: .infinity)
                            .accessibilityHint("")
                        
                        Text(moods[index-1])
                            .foregroundStyle(.white)
                            .font(.footnote)
                            .frame(maxWidth: .infinity)
                            .accessibilityHint("")
                    }
                    .padding(10)
                    .onTapGesture {
                        mood = Int16(6-index)
                        selectedEmoji = index
                    }
                    .accessibilityHint("Press to select this as your current mood")
                    
                }
                
            }
            
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
            .accessibilityHint("Write the title of your note here")
            
            TextField("write a note", text: $noteBody, axis: .vertical)
                .frame(maxHeight: .infinity)
                .padding()
                .accessibilityHint("Write the body of your note here")
            
            if let selectedPhotoData {
                Image(uiImage: UIImage(data: selectedPhotoData)!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            
        }
        .listStyle(PlainListStyle())
        
        
        Spacer()
            
        
        NoteToolBar(
            selectedPhoto: $selectedPhoto,
            selectedPhotoData: $selectedPhotoData,
            recordedAudio: $recordedAudio
        )
        
    }
    
    
}

#Preview {
    WriteNote(showModal: .constant(true))
}
