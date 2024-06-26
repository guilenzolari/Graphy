import Foundation

// Dependency Manager or Dependency Injector
class Dependencies {
    
    // Dependencies
    private(set) var algorithm: AlgorithmModel
    
    private init(algorithm: AlgorithmModel) {
        self.algorithm = algorithm
    }
    
    // Singleton pattern
    // Search for dependency container examples
    static let shared = Dependencies(
        algorithm: AlgorithmModel()
    )
}
