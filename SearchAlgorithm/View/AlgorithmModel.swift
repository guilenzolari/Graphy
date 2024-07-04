import Foundation

@Observable
class AlgorithmModel {
    var path: [String] = []
    var finalPath: [String] = []
    var barrier: [String] = []
    var columnSize: Int = 11
    var rowSize: Int = 16
    var type: AlgorithmType = .none
    var goalNode: String = "16-11"
    var sourceNode: String = "1-1"
    var currentColorIndex: Int = 0
    var timer: Timer? = nil
    var speed: Double = 0.1
}

@Observable
class NodeSelection {
    var nodeType: NodeType = .none
}

enum AlgorithmType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case dfs = "DFS"
    case bfs = "BFS"
    case bidirectionalBfs = "BFS Bidirecional"
    case bidirectionalDfs = "DFS Bidirecional"
//    case aStar = "A*"
//    case dkjstra = "Djkstra"
    case none = "Nenhum"
}
