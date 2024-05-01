//
//  ScoreAnimationView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 01/05/24.
//

import SwiftUI

struct ScoreAnimationView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var score: Int
    private var perfect: String
    private var noob: String
    private var normal: String
    private var musicFile: String = ""

    init(score: Int) {
        self.perfect = "perfect.json"
        self.noob = "noob.json"
        self.normal = "normal.json"
        self.score = score
        self.musicFile = getMusicFile(score: score)
        playMusic(fileName: musicFile)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        Spacer()
                        VStack {
                            LottieView(fileName: getAnimation(score: score), loopMode: .loop, speed: 1)
                                .scaledToFit()
                                .imageScale(.large)
                                .rotationEffect(.degrees(shouldRotate(geo)))
                                .frame(width: geo.size.width * 2, height: geo.size.height * 2)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        }
                        Spacer()
                    }
                }.background(.first)
            }
        }
    }
    
    private func shouldRotate(_ geometry: GeometryProxy) -> Double {
        return verticalSizeClass == .compact ? 0 : 0
    }
    
    private func getAnimation(score: Int) -> String {
        switch score {
        case 0...40:
            return noob
        case 41...70:
            return normal
        case 71...100:
            return perfect
        default:
            return ""
        }
    }
    
    private func getMusicFile(score: Int) -> String {
        switch score {
        case 0...40:
            return "boo.mp3"
        case 41...70:
            return "cheer.mp3"
        case 71...100:
            return "cheer.mp3"
        default:
            return ""
        }
    }
    
    private func playMusic(fileName: String) {

         SongService.instance.preparePlaySong(song: fileName, volume: 0.8)
         SongService.instance.playSong()
    }
}


#Preview {
    ScoreAnimationView(score: 100)
}
