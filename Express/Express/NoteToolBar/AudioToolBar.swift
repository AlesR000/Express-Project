//
//  AudioToolBar.swift
//  Express
//
//  Created by Alessandro Rippa on 17/12/24.
//

import SwiftUI
import AVFoundation

struct AudioToolBar: View {
    
    @ObservedObject var recorderManager = RecorderManager()
    @Binding var recordedAudio: Data?
    
    var body: some View {
        
        Button(action: {
            if recorderManager.isRecording {
                recorderManager.stopRecording()
                transferAudio()
            } else {
                recorderManager.startRecording()
            }
        }) {
            Image(systemName: "waveform")
                .foregroundStyle(recorderManager.isRecording ? .blue : .white)
                .background(recorderManager.isRecording ? Color.white : Color.blue)
                .containerShape(Circle())
        }
        
        //recorderManager.audioData
        
    }
    
    func transferAudio() {
        recordedAudio = recorderManager.audioData
        print("audio recorded")
    }
    
}

class RecorderManager: ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var audioSession: AVAudioSession?
    
    @Published var isRecording = false
    @Published var audioData: Data? = nil
    
    init() {
        setupAudioSession()
    }
    
    // Setup Audio Session
    private func setupAudioSession() {
        audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession?.setCategory(.playAndRecord, mode: .default)
            try audioSession?.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    // Start recording
    func startRecording() {
        guard !isRecording else { return }
        
        let audioFilename = getAudioFileURL()
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            //audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Failed to start recording: \(error)")
        }
    }
    
    // Stop recording
    func stopRecording() {
        guard isRecording else { return }
        
        audioRecorder?.stop()
        audioData = try? Data(contentsOf: getAudioFileURL())
        isRecording = false
    }
    
    // Get the file URL for saving the audio
    private func getAudioFileURL() -> URL {
        let fileManager = FileManager.default
        let directoryURL = fileManager.temporaryDirectory
        let fileURL = directoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("m4a")
        return fileURL
    }
}

/*
#Preview {
    AudioToolBar()
}
*/
