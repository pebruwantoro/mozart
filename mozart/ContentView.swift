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
    
    var notes = [
        Notes(nada: 0, beat: 2),
        Notes(nada: 1, beat: 1),
        Notes(nada: 1, beat: 1),
        Notes(nada: 2, beat: 1),
        Notes(nada: 2, beat: 1),
        Notes(nada: 3, beat: 1),
        Notes(nada: 3, beat: 1),
        
        Notes(nada: 4, beat: 2),
        Notes(nada: 5, beat: 1),
        Notes(nada: 5, beat: 1),
        Notes(nada: 4, beat: 1),
        Notes(nada: 4, beat: 1),
        Notes(nada: 0, beat: 1),
        Notes(nada: 0, beat: 1),
        
        Notes(nada: 1, beat: 2),
        Notes(nada: 2, beat: 1),
        Notes(nada: 2, beat: 1),
        Notes(nada: 3, beat: 1),
        Notes(nada: 3, beat: 1),
        Notes(nada: 4, beat: 1),
        Notes(nada: 4, beat: 1),
        
        Notes(nada: 1, beat: 2),
        Notes(nada: 2, beat: 1),
        Notes(nada: 2, beat: 1),
        Notes(nada: 3, beat: 1),
        Notes(nada: 3, beat: 1),
        Notes(nada: 4, beat: 1),
        Notes(nada: 4, beat: 1),
        
        Notes(nada: 0, beat: 2),
        Notes(nada: 1, beat: 1),
        Notes(nada: 1, beat: 1),
        Notes(nada: 2, beat: 1),
        Notes(nada: 2, beat: 1),
        Notes(nada: 3, beat: 1),
        Notes(nada: 3, beat: 1),
        
        Notes(nada: 4, beat: 2),
        Notes(nada: 5, beat: 1),
        Notes(nada: 5, beat: 1),
        Notes(nada: 4, beat: 1),
        Notes(nada: 4, beat: 1),
        Notes(nada: 0, beat: 1),
        Notes(nada: 0, beat: 1),
    ]
    @State private var timeCount = 0
    private var songTime: Double = 0

    init() {
        self.songTime = songLength(song: "backsound")
    }
    
    var body: some View {
        ZStack{
            MovingBackground()
            
            VStack(spacing: 0){
                HStack(spacing: 30){
                    ForEach(SoundOptions.allCases,id: \.self){ option in
                        Rectangle()
                            .foregroundColor(.fourth.opacity(0.2))
                            .frame(width: 90,height: 320)
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
                VStack(){
                    ForEach(notes) { note in
                        PianoSheet(beat: note.beat, tone: note.nada)
                    }
                }.frame(width:690,height: 0)
                
                HStack(spacing: 30){
                    ForEach(SoundOptions.allCases,id: \.self){ option in
                        SoundView(options: option) {
                            SoundManager.instance.playSound(sound: option)
                        }
                    }
                }.frame(width: 1000).background(Color(.first))
                    .scaledToFill()
                    .safeAreaPadding(.bottom,24)
            }
            ProgressBarMusicView(
                width: 5,
                height: Int(300),
                progress: Int((Double(timeCount) / songTime) * Double(300)))
            .padding(.top, 5)
            .padding(.leading, -380)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
                    self.timeCount += 1

                    if timeCount >= Int(songTime) {
                        time.invalidate()
                    }
                }
            }
        }.onAppear {
            SongService.instance.playSong(song: "backsound", volume: 0.1)
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


struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
