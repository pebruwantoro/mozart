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

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.first.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        
                        LottieView(fileName: "startScreen.json", loopMode: .loop)
                            .scaledToFit()
                            .imageScale(.large)
                            .rotationEffect(.degrees(shouldRotate(geo)))
                            .frame(width: geo.size.width * 3.5, height: geo.size.height * 3.5)
                            .position(x: geo.size.width / 2.2, y: geo.size.height / 1.8)
                        Spacer()
                    }
                }
            }.background(.first)
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                elapsedTime += 1
                if elapsedTime >= 10 {
                    timer.invalidate()
                    shouldShowContentView = true
                }
            }
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
    SplashScreenView()
}
