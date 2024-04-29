//
//  MovingBackground.swift
//  mozart
//
//  Created by Singgih Tulus Makmud on 29/04/24.
//

import SwiftUI

struct MovingBackground: View {
    @State private var xOffset: CGFloat = 0
    @State private var timer: Timer?

    let speed: CGFloat = 1.0 // Adjust the speed of the background

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.xOffset)
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.xOffset + geometry.size.width)
            }
            .onAppear {
                self.startTimer()
            }
            .onDisappear {
                self.stopTimer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            self.updateOffset()
        }
    }

    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }

    func updateOffset() {
        self.xOffset -= speed
        if self.xOffset < -UIScreen.main.bounds.width {
            self.xOffset = 0
        }
    }
}



#Preview {
    MovingBackground()
}
