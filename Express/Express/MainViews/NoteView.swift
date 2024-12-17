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
    let moodColors: [Color] = [.indigo, .blue, .gray.opacity(0.5), .cyan, .yellow]
    
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
                
                
                
                    if note.recording != nil{
                        Text("there is audio")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                
                    Text(note.body ?? "no body")
                        .fontWeight(.light)
                        .padding()
                    
                        
                        
                    DisplayImage(note: note)
                        .padding()
                
            }
            .padding(5)
            .background(.white)
            .containerShape(RoundedRectangle(cornerRadius: 15))
            .padding()
        }
    }
    
    /*
    func DataToAudio(_ data: Data?) ->  {
        
    }
    */
    
}

struct DisplayImage: View{
    
    var note: Note
    
    var body: some View{
        
        if note.image != nil{
            DataToImage(note.image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        
    }
    
    func DataToImage(_ data: Data?) -> Image {
        if let data {
            let uiImageFromData = UIImage(data: data)
            let result = Image(uiImage: uiImageFromData!)
            return result
        }
        return Image("")
    }
}
/*
#Preview {
    NoteView()
}
*/
