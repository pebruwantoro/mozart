//
//  ScoreAnimationView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 01/05/24.
//

import SwiftUI

struct ScoreAnimationView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var score: Int
    private var perfect: String
    private var noob: String
    private var normal: String
    
    init(score: Int) {
        self.perfect = "perfect.json"
        self.noob = "noob.json"
        self.normal = "normal.json"
        self.score = score
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        Spacer()
                        VStack {
                            LottieView(fileName: getAnimation(score: score), loopMode: .loop, speed: 1)
                                .scaledToFit()
                                .imageScale(.large)
                                .rotationEffect(.degrees(shouldRotate(geo)))
                                .frame(width: geo.size.width * 1, height: geo.size.height * 1)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        }
                        Spacer()
                    }
                }.background(.first)
            }
        }
    }
    
    private func shouldRotate(_ geometry: GeometryProxy) -> Double {
        return verticalSizeClass == .compact ? 0 : 0
    }
    
    private func getAnimation(score: Int) -> String {
        var animation: String = ""
        
        if score <= 100 {
            switch score {
            case 0...40:
                animation = noob
            case 41...70:
                animation = normal
            case 70...100:
                animation = perfect
            default:
                animation = ""
            }
        }
        
        return animation
    }
}

#Preview {
    ScoreAnimationView(score: 100)
}
