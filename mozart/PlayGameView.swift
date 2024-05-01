//
//  playGameView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 29/04/24.
//

import SwiftUI

struct PlayGameView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var elapsedTime: TimeInterval = 0
    @State private var shouldShowContentView = false
    
    @State private var backsound: String = "backsound.wav"
    
    init() {
        SongService.instance.preparePlaySong(song: backsound, volume: 0.1)
        SongService.instance.playSong()
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.first.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        LottieView(fileName: "playGame.json", loopMode: .loop, speed: 2.0)
                            .scaledToFit()
                            .imageScale(.large)
                            .rotationEffect(.degrees(shouldRotate(geo)))
                            .frame(width: geo.size.width * 4, height: geo.size.height * 4)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        Spacer()
                    }
                }
            }.background(.first)
        }.onSubmit {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { time in
                elapsedTime += 1
                
                if elapsedTime == 5 {
                    SongService.instance.stopAllSounds()
                }
            }
        }
        .onTapGesture {
            shouldShowContentView = true
        }
        .fullScreenCover(isPresented: $shouldShowContentView) {
            ContentView()
        }
        
    }
    
    private func shouldRotate(_ geometry: GeometryProxy) -> Double {
        return verticalSizeClass == .compact ? 0 : 0
    }
}

#Preview {
    PlayGameView()
}
