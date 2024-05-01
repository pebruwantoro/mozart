//
//  PianoSheet.swift
//  mozart
//
//  Created by Vincent Junior Halim on 29/04/24.
//

import Foundation
import SwiftUI

struct PianoSheet: View {
    @State var pianoOffset: CGFloat = -3050
    @State var beat: Double
    @State var tone : Int
    @State var time:Double =  0.0069
    var body: some View {
        HStack(spacing:30){
            ForEach(0..<6){ i in
                if(tone == i){
                    Rectangle()
                        .size(CGSize(width: 90, height: beat))
                        .fill(.third)
                    
                }
                else if(tone == -1){
                    Rectangle()
                        .size(CGSize(width: 90, height: beat))
                        .opacity(0)
                }
                else{
                    Rectangle()
                        .size(CGSize(width: 0, height: 0))
                }
                
            }
        }.frame(height: 100)
        .offset(y:pianoOffsetValue(beat: beat, offsetVal: pianoOffset))
            .onAppear(){
                Timer.scheduledTimer(withTimeInterval: time, repeats: true){
                    timer in
                    withAnimation(.easeOut(duration: time)){
                        pianoOffset += 1
                        
                    }
                }
            }
    }
    
}

func pianoOffsetValue(beat: Double,offsetVal: CGFloat)->CGFloat{
    var returnVal: CGFloat = offsetVal
    if(beat==100){
       returnVal = offsetVal - 50
    }
    else{
        returnVal = offsetVal - 25
    }
    return returnVal
}
