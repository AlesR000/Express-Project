//
//  GalleryToolBar.swift
//  Express
//
//  Created by Alessandro Rippa on 17/12/24.
//

import SwiftUI
import PhotosUI

struct GalleryToolBar: View {
    
    @Binding var selectedPhoto: PhotosPickerItem?
    @Binding var selectedPhotoData: Data?
    
    var body: some View {
        
        PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()){
            Image(systemName: "photo")
                .foregroundStyle(.white)
        }
        .task(id: selectedPhoto){
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
        
    }
}

/*
#Preview {
    GalleryToolBar()
}
*/
