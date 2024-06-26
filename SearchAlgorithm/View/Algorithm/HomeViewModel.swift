import Foundation

struct HomeViewModel: AlgorithmProtocol {
    
    let algorithm: AlgorithmModel
    
    init(algorithm: AlgorithmModel) {
        self.algorithm = algorithm
    }
}

// MARK: - Actions

extension HomeViewModel {
    private func stopTimer() {
        algorithm.timer?.invalidate()
    }
    
    func clearSimulation() {
        stopTimer()
        algorithm.path = []
        algorithm.currentColorIndex = 0
    }
}
