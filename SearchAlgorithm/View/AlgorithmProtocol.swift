import Foundation

protocol AlgorithmProtocol {
    var getPath: [String] { get }
    var getColumnSize: Int { get }
    var getRowSize: Int { get }
    var getGoalNode: String { get }
    var getSourceNode: String { get }
    
    var algorithm: AlgorithmModel { get }
}

extension AlgorithmProtocol {
    
    var getPath: [String] {
        algorithm.path
    }
    
    var getColumnSize: Int {
        algorithm.columnSize
    }
    
    var getRowSize: Int {
        algorithm.rowSize
    }
    
    var getGoalNode: String {
        algorithm.goalNode
    }
    
    var getSourceNode: String {
        algorithm.sourceNode
    }
}
