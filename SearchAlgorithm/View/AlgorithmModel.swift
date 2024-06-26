import Foundation

@Observable
class AlgorithmModel {
    var path: [String] = []
    var columnSize: Int = 12
    var rowSize: Int = 12
    var type: AlgorithmType = .none
    var goalNode: String = "4-4"
    var sourceNode: String = "1-1"
    var currentColorIndex: Int = 0
    var timer: Timer? = nil
}


enum AlgorithmType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case dfs = "DFS"
    case bfs = "BFS"
    case aStar = "A*"
    case dkjstra = "Djkstra"
    case none = "Nenhum"
}
