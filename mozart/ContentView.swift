//
//  ContentView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var elapsedTime: TimeInterval = 0
    @State private var shouldShowPlayRecordView = false
    
    init() {
        SongService.instance.playSong(song: "backsound", volume: 0.1)
    }
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                HStack(spacing: 30){
                    ForEach(SoundOptions.allCases,id: \.self){ option in
                        Rectangle()
                            .foregroundColor(.fourth.opacity(0.2))
                            .frame(width: 90,height: 320)
                            .aspectRatio(contentMode: .fill)
                    }
                }
                HStack(spacing: 30){
                    ForEach(SoundOptions.allCases,id: \.self){ option in
                        SoundView(options: option) {
                            SoundManager.instance.playSound(sound: option)
                        }
                    }
                }
            }
        }.onAppear {
            AudioRecorder.instance.startRecording()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                elapsedTime += 1
                if elapsedTime >= 15 {
                    timer.invalidate()
                    shouldShowPlayRecordView = true
                    stopAllActivity()
                }
            }
        }
        .fullScreenCover(isPresented: $shouldShowPlayRecordView) {
            PlayRecordSongView().onAppear {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    playRecordedSong()
                    print("song should be played")
                }
            }
        }

    }
    
    private func stopAllActivity() {
        SongService.instance.stopAllSounds()
        AudioRecorder.instance.stopRecording()
    }
    
    private func playRecordedSong() {
        AudioRecorder.instance.playSong()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
