//
//  WritingToolBar.swift
//  Express
//
//  Created by Alessandro Rippa on 12/12/24.
//

import SwiftUI
import PhotosUI

struct WritingToolBar: View {
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State var showCamera = false
    
    var body: some View {
        
        HStack{
            
            Spacer()
            
            Image(systemName: "pencil.and.scribble")
                .foregroundStyle(.white)
            
            Spacer()
            
            Button{
                showCamera = true
            } label: {
                Image(systemName: "camera.fill")
                    .foregroundStyle(.white)
            }
            .sheet(isPresented: $showCamera) {
                CameraToolBar(showCamera: $showCamera)
            }
            
            Spacer()
            
            if selectedPhotoData == nil {
                PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                    Label("", systemImage: "photo")
                        .foregroundStyle(.white)
                }
                
                .task(id: selectedPhoto){
                    if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                        selectedPhotoData = data
                    }
                }
            }
            
            Spacer()
            
            Image(systemName: "waveform")
                .foregroundStyle(.white)
            
            Spacer()
            
            Image(systemName: "map.fill")
                .foregroundStyle(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.blue)
        
    }
}

#Preview {
    WritingToolBar()
}
