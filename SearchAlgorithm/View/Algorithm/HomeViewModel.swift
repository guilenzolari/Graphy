import Foundation

struct HomeViewModel: AlgorithmProtocol {
    
    let algorithm: AlgorithmModel
    
    init(algorithm: AlgorithmModel) {
        self.algorithm = algorithm
    }
}
