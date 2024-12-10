//
//  CollectionViewModel.swift
//  Express
//
//  Created by Alessandro Rippa on 07/12/24.
//

import SwiftUI
import CoreData

/*
struct CollectionViewModel: View {
    
    //MARK: Properties
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    
    @State var selectedDay: Date? = nil
    @State private var selectedNote: Note? = nil
    
    
    @State var showModal: Bool = false
    @State var showNote: Bool = false
    
    //MARK: Body
    var body: some View {
        
        ZStack{
            
            //Color.teal.ignoresSafeArea()
            //Color.white.ignoresSafeArea()
            
            VStack {
                
                CalendarWeekView(selectedDay: $selectedDay)
                
                Text(selectedDay?.formatted(date: .abbreviated, time: .omitted) ?? "Select a day")
                
                
                Button("Express your day"){
                    showModal = true
                }
                .font(.title)
                .sheet(isPresented: $showModal){WriteNote(showModal: $showModal)}
                .padding()
                
                FilteredNotes(filter: $selectedDay?)
                }
                
                List(){
                    
                    /*
                    VStack(alignment: .leading){
                        
                        Text("no title")
                            .foregroundStyle(.black)
                            .underline()
                            .font(.title2)
                            .padding([.top, .leading,.trailing])
                            .padding(.bottom, 5)
                        
                        Text( "no body")
                            .foregroundStyle(.black)
                            .padding([.leading, .bottom, .trailing])
                            .multilineTextAlignment(.leading)
                        
                        HStack {
                            Spacer()
                            
                            Text(Date.now.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.trailing)
                            
                        }
                        .padding([.bottom, .trailing], 5.0)
                    }
                    .background(.ultraThinMaterial)
                    .containerShape(RoundedRectangle(cornerRadius: 10))
                    */
                    
                    ForEach(notes){note in
                    
                        Button{
                            
                            selectedNote = note
                            print("\(note.title ?? "no title") pressed")
                            
                            showNote = true
                            
                        }label:{
                            VStack(alignment: .leading){
                                
                                Text(note.title ?? "no title")
                                    .underline()
                                    .font(.title2)
                                    .padding([.top, .leading,.trailing])
                                    .padding(.bottom, 5)
                                
                                Text(note.body ?? "no body")
                                    .padding([.leading, .bottom, .trailing])
                                    .multilineTextAlignment(.leading)
                                
                                HStack {
                                    Spacer()
                                    
                                    Text(note.date?.formatted(date: .abbreviated, time: .shortened) ?? "no date")
                                        .multilineTextAlignment(.trailing)
                                    
                                }
                                .padding([.bottom, .trailing], 5.0)
                                
                            }
                            .background(.ultraThinMaterial)
                            .containerShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                            
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        
                    }
                    .onDelete(perform: deleteNote)
                    .sheet(isPresented: $showNote) {
                        if let selectedNote = selectedNote {
                            NoteView(note: selectedNote)
                        }
                    }
                    
                }.listStyle(PlainListStyle())
           
        }
    }
    
    
    //MARK: Functions
    func deleteNote(at offsets: IndexSet){
        for offset in offsets {
            let note = notes[offset]
            moc.delete(note)
            try? moc.save()
        }
    }
    
    
}

/*
 class AVCaptureDevice{
 
 // Create the capture session.
 let captureSession = AVCaptureSession()
 
 
 // Find the default audio device.
 guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
 
 
 do {
 // Wrap the audio device in a capture device input.
 let audioInput = try AVCaptureDeviceInput(device: audioDevice)
 // If the input can be added, add it to the session.
 if captureSession.canAddInput(audioInput) {
 captureSession.addInput(audioInput)
 }
 } catch {
 // Configuration failed. Handle error.
 }
 
 }
 */

    //MARK: Preview
#Preview {
    CollectionViewModel()
}

*/
