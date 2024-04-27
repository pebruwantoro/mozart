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
        ZStack{
            Color(.second).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            GeometryReader { geo in
                Image("playRecoded")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(shouldRotate(geo)))
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
        }
    }
    
    private func shouldRotate(_ geometry: GeometryProxy) -> Double {
        return verticalSizeClass == .compact ? 0 : 0
    }
}

#Preview {
    PlayRecordSongView()
}
