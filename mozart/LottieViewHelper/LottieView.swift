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
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: fileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
}
