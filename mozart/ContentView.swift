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
    @State private var timeCount = 0
    private var song: String = "twinkleLittleStarAssest.mp3"
    private var songDuration: String = ""
    private var songTime: Double = 0
    
    init() {
        self.songDuration = songDuration(song: song)
        self.songTime = songLength(song: song)
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
            
            GeometryReader { geo in
                ProgressBarMusicView(
                    width: 10,
                    height: Int(geo.size.height),
                    progress: Int((Double(timeCount) / songTime) * Double(geo.size.height)))
                    .padding(.top, 10)
                    .padding(.leading, -20)
                    .onAppear {                            
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
                                self.timeCount += 1
                                if timeCount >= Int(songTime) {
                                    time.invalidate()
                                }
                            }
                    }
            }
        }
        .onTapGesture {
            SongService.instance.playSong(song: song, volume: 0.3)
            AudioRecorder.instance.startRecording()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                elapsedTime += 1
                if elapsedTime >= songTime {
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
