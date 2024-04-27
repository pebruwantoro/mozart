//
//  PlayRecordSongView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 26/04/24.
//

import SwiftUI

struct PlayRecordSongView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.first.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        LottieView(fileName: "playSong.json", loopMode: .loop)
                            .scaledToFit()
                            .imageScale(.large)
                            .rotationEffect(.degrees(shouldRotate(geo)))
                            .frame(width: geo.size.width * 1, height: geo.size.height * 1)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        Spacer()
                    }
                }
            }.background(.first)
        }
    }
    
    private func shouldRotate(_ geometry: GeometryProxy) -> Double {
        return verticalSizeClass == .compact ? 0 : 0
    }
}

#Preview {
    PlayRecordSongView()
}
