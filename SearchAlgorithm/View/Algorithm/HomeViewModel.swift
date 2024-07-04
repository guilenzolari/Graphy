import Foundation
import UIKit

struct HomeViewModel: AlgorithmProtocol {
    
    let algorithm: AlgorithmModel
    let nodeSelection: NodeSelection
    
    init(algorithm: AlgorithmModel, nodeSelection: NodeSelection) {
        self.algorithm = algorithm
        self.nodeSelection = nodeSelection
    }
}

// MARK: - Actions

extension HomeViewModel {
    private func setType(for type: AlgorithmType) {
        algorithm.type = type
    }
    
    private func getAlgorithm() {
        let graph = generateGraph(columnSize: algorithm.columnSize, rowSize: algorithm.rowSize, barrier: algorithm.barrier)
        
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
            algorithm.timer = Timer.scheduledTimer(withTimeInterval: (0.21-getSpeed), repeats: false) { _ in
                if self.algorithm.currentColorIndex < path.maxSize {
                    
                    self.algorithm.path.append(contentsOf: path.nodes(for: self.algorithm.currentColorIndex))
                    self.algorithm.currentColorIndex += 1
                    vibrate()
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
        
        func startTimer() {
            algorithm.timer = Timer.scheduledTimer(withTimeInterval: (0.21-getSpeed), repeats: false) { _ in
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
                
                if self.algorithm.currentColorIndex <= path.startMaxSize || self.algorithm.currentColorIndex <= path.endMaxSize {
                    vibrate()
                    self.algorithm.currentColorIndex += 1
                    startTimer()
                }
            }
        }
        startTimer()
    }
    
    func stopTimer() {
        algorithm.timer?.invalidate()
    }
    
    func clearSimulation() {
        stopTimer()
        algorithm.path = []
        algorithm.currentColorIndex = 0
    }
    
    func clearGrid() {
        stopTimer()
        algorithm.path = []
        algorithm.barrier = []
        algorithm.type = .none
        algorithm.goalNode = "16-11"
        algorithm.sourceNode = "1-1"
        algorithm.currentColorIndex = 0
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
