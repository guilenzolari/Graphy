import Foundation

struct SelectionViewModel: AlgorithmProtocol {
    
    let algorithm: AlgorithmModel
    
    init(algorithm: AlgorithmModel) {
        self.algorithm = algorithm
    }
}
