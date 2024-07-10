import Foundation
import UIKit

struct HomeViewModel: AlgorithmProtocol {
    
    let algorithm: AlgorithmModel
    let nodeSelection: NodeSelection
    
    init(
        algorithm: AlgorithmModel,
        nodeSelection: NodeSelection
    ) {
        self.algorithm = algorithm
        self.nodeSelection = nodeSelection
    }
}

// MARK: - Actions

extension HomeViewModel {
    private func setType(
        for type: AlgorithmType
    ) {
        algorithm.type = type
    }
    
    private func getAlgorithm() {
        let graph = generateGraph(
            columnSize: algorithm.columnSize,
            rowSize: algorithm.rowSize,
            barrier: algorithm.barrier
        )
        
        switch(
            algorithm.type
        ) {
        case .bfs: let path = breadthFirst(
            graph: graph,
            source: algorithm.sourceNode,
            goal: algorithm.goalNode
        )
            fillSinglePath(
                for: path
            )
            
        case .dfs: let path = depthFirst(
            graph: graph,
            source: algorithm.sourceNode,
            goal: algorithm.goalNode
        )
            fillSinglePath(
                for: path
            )
        case .bidirectionalBfs: let path = bidirectionaBFS(
            graph: graph,
            source: algorithm.sourceNode,
            goal: algorithm.goalNode
        )
            fillDoublePath(
                for: path
            )
        case .bidirectionalDfs: let path = bidirectionaDFS(
            graph: graph,
            source: algorithm.sourceNode,
            goal: algorithm.goalNode
        )
            fillDoublePath(
                for: path
            )
            //        case .aStar:
            //            return []
            //        case .dkjstra:
            //            return []
            case .none: break    }
    }
    
    func startSimulation(
        for type: AlgorithmType
    ) {
        clearSimulation()
        setType (
            for: type
        )
        
        getAlgorithm()
    }
    
    func fillSinglePath(
        for path: SolutionPath
    ) {
        algorithm.timer?.invalidate()
        
        func startTimer(
            for finalPath: Bool = false
        ) {
            algorithm.timer = Timer.scheduledTimer(
                withTimeInterval: (
                    0.21 - getSpeed
                ),
                repeats: false
            ) { _ in
                let size = if finalPath {
                    path.finalPathMaxSize
                } else {
                    path.visitedMaxSize
                }
                if self.algorithm.currentColorIndex < size {
                    if finalPath {
                        self.algorithm.finalPath.append(
                            contentsOf: path.finalNodes(
                                for: self.algorithm.currentColorIndex
                            )
                        )
                    } else {
                        self.algorithm.path.append(
                            contentsOf: path.nodes(
                                for: self.algorithm.currentColorIndex
                            )
                        )
                    }
                    
                    self.algorithm.currentColorIndex += 1
                    vibrate()
                    startTimer(
                        for: finalPath
                    )
                } else {
                    if !finalPath {
                        self.algorithm.currentColorIndex = 0
                        startTimer(
                            for: true
                        )
                    } else {
                        self.algorithm.timer?.invalidate()
                    }
                }
            }
        }
        
        startTimer()
    }
    
    func fillDoublePath(
        for path: DoublePathSolution
    ) {
        algorithm.timer?.invalidate()
        
        func startTimer(
            for finalPath: Bool = false
        ) {
            algorithm.timer = Timer.scheduledTimer(
                withTimeInterval: (
                    0.21 - getSpeed
                ),
                repeats: false
            ) { _ in
                if finalPath {
                    let startSize = path.startFinalPathSize
                    let endSize = path.endFinalPathSize
                    
                    if self.algorithm.currentColorIndex < startSize {
                        self.algorithm.finalPath.append(
                            contentsOf: path.finalStartNodes(
                                for: self.algorithm.currentColorIndex
                            )
                        )
                    }
                    
                    if self.algorithm.currentColorIndex < endSize {
                        self.algorithm.finalPath.append(
                            contentsOf: path.finalEndNodes(
                                for: self.algorithm.currentColorIndex
                            )
                        )
                    }
                    
                    if self.algorithm.currentColorIndex < startSize || self.algorithm.currentColorIndex < endSize {
                        self.algorithm.currentColorIndex += 1
                        vibrate()
                        startTimer(
                            for: finalPath
                        )
                    } else {
                        self.algorithm.timer?.invalidate()
                    }
                } else {
                    let startSize = path.startMaxSize
                    let endSize = path.endMaxSize
                    
                    if self.algorithm.currentColorIndex < startSize {
                        self.algorithm.path.append(
                            contentsOf: path.startNodes(
                                for: self.algorithm.currentColorIndex
                            )
                        )
                    }
                    
                    if self.algorithm.currentColorIndex < endSize {
                        self.algorithm.path.append(
                            contentsOf: path.endNodes(
                                for: self.algorithm.currentColorIndex
                            )
                        )
                    }
                    
                    if self.algorithm.currentColorIndex < startSize || self.algorithm.currentColorIndex < endSize {
                        self.algorithm.currentColorIndex += 1
                        vibrate()
                        startTimer(
                            for: finalPath
                        )
                    } else {
                        self.algorithm.currentColorIndex = 0
                        startTimer(
                            for: true
                        )
                    }
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
        algorithm.finalPath = []
        algorithm.currentColorIndex = 0
    }
    
    func clearGrid() {
        stopTimer()
        algorithm.path = []
        algorithm.finalPath = []
        algorithm.barrier = []
        algorithm.type = .none
        algorithm.goalNode = "16-11"
        algorithm.sourceNode = "1-1"
        algorithm.currentColorIndex = 0
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(
            style: .light
        )
        generator.impactOccurred()
    }
}
