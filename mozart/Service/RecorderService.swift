//
//  RecorderService.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 26/04/24.
//

import Foundation
import AVFoundation


class AudioRecorder: NSObject , ObservableObject , AVAudioPlayerDelegate  {
    static let instance = AudioRecorder()
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    func startRecording(){
            
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.multiRoute, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("recording.wav")
        print("ini path di record",path)
        print("ini filename di record", fileName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
//            audioRecorder.
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    func stopRecording(){
        audioRecorder.stop()
        print("recording stop", audioRecorder.isRecording)
    }
    
    func playSong() {
//        let playSession = AVAudioSession.sharedInstance()
//        do {
//            try playSession.setCategory(.playAndRecord, mode: .default)
//            try playSession.setActive(true)
//        } catch let error {
//            print("error play session: \(error.localizedDescription)")
//        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("recording.wav")
        print("ini path",path)
        print("ini filename", fileName)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileName)
//            audioPlayer.volume = 100
//            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print("Error playing recorded sound: \(error.localizedDescription)")
        }
    }
}
