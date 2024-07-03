import Foundation

// Dependency Manager or Dependency Injector
class Dependencies {
    
    // Dependencies
    private(set) var algorithm: AlgorithmModel
    private(set) var nodeSelection: NodeSelection
    
    private init(algorithm: AlgorithmModel, nodeSelection: NodeSelection) {
        self.algorithm = algorithm
        self.nodeSelection = nodeSelection
    }
    
    // Singleton pattern
    // Search for dependency container examples
    static let shared = Dependencies(
        algorithm: AlgorithmModel(),
        nodeSelection: NodeSelection()
    )
}

