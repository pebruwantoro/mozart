//
//  LottieView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 27/04/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    var fileName: String
    let loopMode: LottieLoopMode
    let speed: Float
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: fileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = CGFloat(speed)
        animationView.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
        return animationView
    }
}
