//
//  WritingToolBar.swift
//  Express
//
//  Created by Alessandro Rippa on 12/12/24.
//

import SwiftUI
import PhotosUI

struct NoteToolBar: View {
    
    @Binding var selectedPhoto: PhotosPickerItem?
    @Binding var selectedPhotoData: Data?
    @Binding var recordedAudio: Data?
    
    
    var body: some View {
        
        HStack{
            
            Spacer()
            
            Image(systemName: "pencil.and.scribble")
                .foregroundStyle(.white)
            
            Spacer()
            
            CameraIcon()
            
            Spacer()
            
            GalleryToolBar(selectedPhoto: $selectedPhoto, selectedPhotoData: $selectedPhotoData)
            
            Spacer()
            
            AudioToolBar(recordedAudio: $recordedAudio)
            
            Spacer()
            
            Image(systemName: "map.fill")
                .foregroundStyle(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.blue)
        
    }
}

/*
#Preview {
    
    WritingToolBar()
    
}
*/
