//
//  NoteView.swift
//  Express
//
//  Created by Alessandro Rippa on 05/12/24.
//

import SwiftUI

struct NoteView: View {
    
    @StateObject var note: Note
    let emojis: [String] = ["TerribleEmoji", "SadEmoji", "NeutralEmoji", "HappyEmoji", "AmazingEmoji"]
    let moodColors: [Color] = [.indigo, .blue, .gray, .cyan, .yellow]
    
    var body: some View {
        
        ZStack{
            
            moodColors[Int(note.mood) - 1]
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    VStack(alignment: .leading){
                        Text(note.title ?? "no title")
                            .font(.title)
                            .padding([.top, .leading, .trailing])
                        
                        Text(note.date?.formatted(date: .complete, time: .shortened) ?? "no date")
                            .font(.caption)
                            .padding([.leading, .bottom, .trailing])
                    }
                    
                    Spacer()
                    
                    Image(emojis[Int(note.mood) - 1])
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
            
                }
                
                Text(note.body ?? "no body")
                    .padding()
                
            }
            .padding(5)
            .background(.thinMaterial)
            .containerShape(RoundedRectangle(cornerRadius: 15))
            .padding()
        }
    }
}

/*
#Preview {
    NoteView()
}
*/
