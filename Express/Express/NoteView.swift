//
//  NoteView.swift
//  Express
//
//  Created by Alessandro Rippa on 05/12/24.
//

import SwiftUI

struct NoteView: View {
    
    @StateObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(note.title ?? "no title")
                .font(.title)
                .padding([.top, .leading, .trailing])
            HStack {
                Text(note.date?.formatted(date: .complete, time: .shortened) ?? "no date")
                    .font(.subheadline)
                    .padding([.leading, .bottom, .trailing])
                Spacer()
            }
            Text(note.body ?? "no body")
                .padding()
            
        }.padding()
    }
}

/*
#Preview {
    NoteView(    )
}
*/
