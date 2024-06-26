import Foundation

class AlgorithmViewModel {
    
    private let algorithm: AlgorithmModel
    
    init(algorithm: AlgorithmModel) {
        self.algorithm = algorithm
    }
}

// MARK: - Presentation

extension AlgorithmViewModel {
    var algorithmPath: [String] {
        algorithm.path
    }
    
    var algorithmColumnSize: Int {
        algorithm.columnSize
    }
    
    var algorithmRowSize: Int {
        algorithm.rowSize
    }
    
    var algorithmGoalNode: String {
        algorithm.goalNode
    }
    
    var algorithmSourceNode: String {
        algorithm.sourceNode
    }
}

// MARK: - Actions

extension AlgorithmViewModel {
    
    private func setType(for type: AlgorithmType) {
        algorithm.type = type
    }
    
    private func getAlgorithm() -> [String] {
        let graph = generateGraph(columnSize: algorithm.columnSize, rowSize: algorithm.rowSize)
        switch(algorithm.type) {
        case .bfs: return breadthFirst(graph: graph, source: algorithm.sourceNode, goal: algorithm.goalNode)
        case .dfs: return depthFirst(graph: graph, source: algorithm.sourceNode, goal: algorithm.goalNode)
        case .aStar:
            return []
        case .dkjstra:
            return []
        case .none: return []
        }
    }
    
    func startSimulation(for type: AlgorithmType) {
        clearSimulation()
        setType (for: type)
        let path = getAlgorithm()
        
        algorithm.timer?.invalidate()
        algorithm.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if self.algorithm.currentColorIndex < path.count {
                self.algorithm.path.append(path[self.algorithm.currentColorIndex])
                self.algorithm.currentColorIndex += 1
            } else {
                self.algorithm.timer?.invalidate()
            }
        }
    }

    func stopTimer() {
        algorithm.timer?.invalidate()
    }
    
    func clearSimulation() {
        stopTimer()
        algorithm.path = []
        algorithm.currentColorIndex = 0
    }
}
