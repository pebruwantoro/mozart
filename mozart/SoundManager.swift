//
//  SoundManager.swift
//  mozart
//
//  Created by Singgih Tulus Makmud on 26/04/24.
//

import Foundation
import AVKit

class SoundManager{
    static let instance = SoundManager()
    
    var player:AVAudioPlayer?
    
    func playSound(sound:SoundOptions){
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error{
            print("Error: \(error.localizedDescription)")
        }
        
    }
}

enum SoundOptions:String,CaseIterable{
    case c
    case d
    case e
    case f
    case g
    case a
//    case b
//    case coctave
}

