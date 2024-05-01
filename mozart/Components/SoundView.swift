//
//  SoundView.swift
//  mozart
//
//  Created by Singgih Tulus Makmud on 26/04/24.
//

import SwiftUI

struct SoundView: View {
    @State private var counter = 0
    let options: SoundOptions
    let action: () -> Void
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            counter += 1
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            action()
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isPressed = false
                }
            }
        }) {
            Rectangle()
                .foregroundColor(isPressed ? .black : .fourth)
                .frame(width: 90, height: 50)
                .aspectRatio(contentMode: .fill)
                .shadow(radius: 10)
                .scaleEffect(isPressed ? 1.1 : 1.0)
        }
    }
}





