//
//  ProgressBarMusicView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 29/04/24.
//

import SwiftUI

struct ProgressBarMusicView: View {
    var width: Int = 0
        var height: Int = 0
        var progress: Int = 0

        var body: some View {
            VStack {
                Rectangle()
                    .fill(.black)
                    .frame(width: CGFloat(width), height: CGFloat(height-progress))
                Rectangle()
                    .fill(.third)
                    .frame(width: CGFloat(width), height: CGFloat(progress))
                    .padding(.top, -10)
            }
        }}

#Preview {
    ProgressBarMusicView()
}
