import Foundation

struct Notes: Identifiable{
    let id = UUID()
    let nada : Int
    let beat : Double
    
    init(nada: Int, beat: Double) {
        self.nada = nada
        self.beat = beat*50
    }
}
