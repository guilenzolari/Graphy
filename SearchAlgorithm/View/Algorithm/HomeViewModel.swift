import Foundation

struct HomeViewModel: AlgorithmProtocol {
    
    let algorithm: AlgorithmModel
    
    init(algorithm: AlgorithmModel) {
        self.algorithm = algorithm
    }
}

// MARK: - Actions

extension HomeViewModel {
    private func setType(for type: AlgorithmType) {
        algorithm.type = type
    }
    
    private func getAlgorithm() {
        let graph = generateGraph(columnSize: algorithm.columnSize, rowSize: algorithm.rowSize)
        
        switch(algorithm.type) {
        case .bfs: let path = breadthFirst(graph: graph, source: algorithm.sourceNode, goal: algorithm.goalNode)
            fillSinglePath(for: path)
        case .dfs: let path = depthFirst(graph: graph, source: algorithm.sourceNode, goal: algorithm.goalNode)
            fillSinglePath(for: path)
        case .bidirectionalBfs: let path = bidirectionaBFS(graph: graph, source: algorithm.sourceNode, goal: algorithm.goalNode)
            fillDoublePath(for: path)
        case .bidirectionalDfs: let path = bidirectionaDFS(graph: graph, source: algorithm.sourceNode, goal: algorithm.goalNode)
            fillDoublePath(for: path)
//        case .aStar:
//            return []
//        case .dkjstra:
//            return []
        case .none: break    }
    }
    
    func startSimulation(for type: AlgorithmType) {
        clearSimulation()
        setType (for: type)
        
        getAlgorithm()
    }
    
    func fillSinglePath(for path: SolutionPath) {
        algorithm.timer?.invalidate()
        
        func startTimer() {
            algorithm.timer = Timer.scheduledTimer(withTimeInterval: getSpeed, repeats: false) { _ in
                if self.algorithm.currentColorIndex < path.maxSize {
                    self.algorithm.path.append(contentsOf: path.nodes(for: self.algorithm.currentColorIndex))
                    self.algorithm.currentColorIndex += 1
                    
                    startTimer()
                } else {
                    self.algorithm.timer?.invalidate()
                }
            }
        }
        
        startTimer()
    }

    
    func fillDoublePath(for path: DoublePathSolution) {
        algorithm.timer?.invalidate()
        algorithm.timer = Timer.scheduledTimer(withTimeInterval: getSpeed, repeats: true) { _ in
            if self.algorithm.currentColorIndex < path.startMaxSize {
                self.algorithm.path.append(contentsOf: path.startNodes(for: algorithm.currentColorIndex))
                
            } else {
                self.algorithm.timer?.invalidate()
            }
            
            if self.algorithm.currentColorIndex < path.endMaxSize {
                self.algorithm.path.append(contentsOf: path.endNodes(for: algorithm.currentColorIndex))
            } else {
                self.algorithm.timer?.invalidate()
            }
            
            if self.algorithm.currentColorIndex < path.startMaxSize || self.algorithm.currentColorIndex < path.endMaxSize {
                self.algorithm.currentColorIndex += 1
            }
        }
    }
    
    private func stopTimer() {
        algorithm.timer?.invalidate()
    }
    
    func clearSimulation() {
        stopTimer()
        algorithm.path = []
        algorithm.currentColorIndex = 0
    }
}
