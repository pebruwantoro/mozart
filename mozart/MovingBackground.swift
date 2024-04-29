import SwiftUI

struct MovingBackground: View {
    @State private var xOffset: CGFloat = 0
    @State private var timer: Timer?

    let speed: CGFloat = 0.7
    let numberOfBackgrounds = 10 // Adjust the number of background images as needed

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<self.numberOfBackgrounds) { index in
                        Image("background")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .frame(width: geometry.size.width * CGFloat(self.numberOfBackgrounds), height: geometry.size.height)
                .offset(x: self.xOffset)
            }
            .onAppear {
                self.startTimer()
            }
            .onDisappear {
                self.stopTimer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            self.updateOffset()
        }
    }

    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }

    func updateOffset() {
        self.xOffset -= speed
        let totalWidth = UIScreen.main.bounds.width * CGFloat(self.numberOfBackgrounds)
        if self.xOffset <= -totalWidth {
            // Reset the offset to ensure continuous looping
            self.xOffset = 0
        }
    }
}

struct MovingBackground_Previews: PreviewProvider {
    static var previews: some View {
        MovingBackground()
    }
}
