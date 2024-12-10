//
//  AudioViewModel.swift
//  Express
//
//  Created by Alessandro Rippa on 09/12/24.
//

import SwiftUI
import AVFoundation

struct AudioViewModel: View {
    
    @State var audioRecorder : AVAudioRecorder?
    @State var audioPlayer : AVAudioPlayer?
    
    var body: some View {
        
        
        VStack(spacing: 60){
            
            Button("start recording"){
                startRecording()
            }
            
            Button("stop recording"){
                stopRecording()
            }
            
            Button("play recording"){
                playRecording()
            }
            
        }
        
    }
    
    

    func startRecording(){
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            let audioURL = URL.applicationDirectory.appendingPathComponent("audio.m4a")
            
            let settings : [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            
            
            audioRecorder?.record()
            
            print("started recording")
            
            
        } catch {
            print("failed to initialize recording: \(error.localizedDescription)")
        }
        
    }

    func stopRecording(){
        
        audioRecorder?.stop()
        audioRecorder = nil
        
        print("stopped recording")
        
    }

    func playRecording() {

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: .applicationDirectory.appendingPathComponent("audio.m4a"))
            audioPlayer?.play()  // Play the audio
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

#Preview {
 AudioViewModel()
}

