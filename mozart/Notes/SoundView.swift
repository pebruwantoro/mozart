//
//  SoundView.swift
//  mozart
//
//  Created by Singgih Tulus Makmud on 26/04/24.
//

import SwiftUI

struct SoundView: View {
    let options:SoundOptions
    let action:() -> Void
    var body: some View {
        Button(action: action) {
            Rectangle()
                .frame(width: 80,height: 44)
                .aspectRatio(contentMode: .fill)
                .padding()
                .shadow(radius: 10)
        }
    }
}


