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
    
    private var audioRecorder : AVAudioRecorder!
    private var audioPlayer : AVAudioPlayer!
    private var session : AVAudioSession! = AVAudioSession.sharedInstance()
    
    func startRecording(){
        let options = [
            AVAudioSession.CategoryOptions.defaultToSpeaker,
            AVAudioSession.CategoryOptions.duckOthers,
            AVAudioSession.CategoryOptions.interruptSpokenAudioAndMixWithOthers
        ]
        
        do {
            try session.setCategory(.playAndRecord, mode: .spokenAudio, options: AVAudioSession.CategoryOptions(options))
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            fatalError("Can not setup the Recording: \(error.localizedDescription)")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("recording.wav")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch let error {
            fatalError("Failed to Setup the Recording: \(error.localizedDescription)")
        }
    }
    
    
    func stopRecording(){
        audioRecorder.stop()
    }
    
    func playSong() {
        do {
            try session.setCategory(.soloAmbient, mode: .default, options: .duckOthers)
            try session.setActive(true)
        } catch let error {
            fatalError("error play session: \(error.localizedDescription)")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("recording.wav")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileName)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            fatalError("Error playing recorded sound: \(error.localizedDescription)")
        }
    }    
}
