//
//  SessionSetup.swift
//  Express
//
//  Created by Alessandro Rippa on 09/12/24.
//

import Foundation
import AVFoundation

var audioRecorder : AVAudioRecorder?

func startRecording(){
    
    let recordingSession = AVAudioSession.sharedInstance()
    
    do {
        
        try recordingSession.setCategory(.playAndRecord, mode: .default)
        try recordingSession.setActive(true)
        
        let settings : [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try AVAudioRecorder(url: .applicationDirectory.appendingPathComponent("audio.m4a"), settings: settings)
            
        
        audioRecorder?.record()
        
        print("started recording")
        
        
    } catch {
        print("failed to initialize recording: \(error.localizedDescription)")
    }
    
}

func stopRecording(){
    
    audioRecorder?.stop()
    audioRecorder = nil
    
}
