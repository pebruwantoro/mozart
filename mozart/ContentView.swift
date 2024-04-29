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
//    @State private var playingSong: String = "backsound"
//    
//    private var songDuration: String = ""
      
//    init() {
//        SongService.instance.playSong(song: backsound, volume: 0.1)
//        self.backsoundDuration = songDuration(song: backsound)
//    }
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
//            VStack {
//                // GET SONG DURATION
//                Text("Song duration \(songDuration)")
//            }
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
                if elapsedTime >= 10 {
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
    
    private func songLength(song: String) -> Double {
        return SongService.instance.getSongDuration(file: song)
    }
    
    private func songDuration(song: String) -> String {
        let duration = SongService.instance.getSongDuration(file: song)
        let minutes = Int(duration / 60)
        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
