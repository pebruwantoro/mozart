//
//  ContentView.swift
//  mozart
//
//  Created by Doni Pebruwantoro on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack{
            Spacer()
            HStack {
                ForEach(SoundOptions.allCases,id: \.self){ option in
                    SoundView(options: option) {
                        SoundManager.instance.playSound(sound: option)
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
