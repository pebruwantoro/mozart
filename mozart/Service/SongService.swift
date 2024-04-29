//
//  SoundService.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 26/04/24.
//

import Foundation
import AVFoundation

class SongService {
    static let instance = SongService()
    
    private var player: AVAudioPlayer!
    
    func playSong(song: String, volume: Float?) {
        guard let url = Bundle.main.url(forResource: song, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            if let initVolume = volume {
                player?.volume = initVolume
            }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            fatalError("Error playing sound 1: \(error.localizedDescription)")
        }
    }
        
    func stopAllSounds() {
        player?.stop()
    }
    
    func getSongDuration(file: String) -> Double {
        guard let url = Bundle.main.url(forResource: file, withExtension: "mp3")
        else {
            fatalError("Can't find the song")
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            let duration = audioPlayer.duration
            
            return duration
        } catch let error {
            fatalError("Error get duration song: \(error.localizedDescription)")
        }
    }
}
