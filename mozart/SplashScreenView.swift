//
//  SplashScreenView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 27/04/24.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var elapsedTime: TimeInterval = 0
    @State private var shouldShowContentView = false
    @State private var soundsLoaded = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.first.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        
                        LottieView(fileName: "splashScreenAnimation.json", loopMode: .loop, speed: 1)
                            .scaledToFit()
                            .imageScale(.large)
                            .rotationEffect(.degrees(shouldRotate(geo)))
                            .frame(width: geo.size.width * 1, height: geo.size.height * 1)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        Spacer()
                    }
                }
            }.background(.first)
        }.onAppear {
            preloadSounds()
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                elapsedTime += 1
                if elapsedTime == 4 {
                    timer.invalidate()
                    shouldShowContentView = true
                }
            }
        }
        .fullScreenCover(isPresented: $shouldShowContentView) {
            PlayGameView()
        }
        
    }
    
    private func shouldRotate(_ geometry: GeometryProxy) -> Double {
        return verticalSizeClass == .compact ? 0 : 0
    }
    
    private func preloadSounds() {
        DispatchQueue.global().async {
            
            SoundManager.instance.preloadSounds()
            
            DispatchQueue.main.async {
                self.soundsLoaded = true
                
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
