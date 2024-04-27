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
    
    private var player: AVAudioPlayer?
    
    func playSong(song: String, volume: Float?) {
        guard let url = Bundle.main.url(forResource: song, withExtension: "wav") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            if let initVolume = volume {
                player?.volume = initVolume
            }
            
            player?.play()
        } catch let error {
            print("Error playing sound 1: \(error.localizedDescription)")
        }
    }
        
    func stopAllSounds() {
        player?.stop()
    }
}
