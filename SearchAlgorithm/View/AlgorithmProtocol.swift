import Foundation

protocol AlgorithmProtocol {
    var getPath: [String] { get set }
    var getColumnSize: Int { get }
    var getRowSize: Int { get }
    var getGoalNode: String { get }
    var getSourceNode: String { get }
    var getType: AlgorithmType { get }
    var getSpeed: Double { get  set}
    
    var algorithm: AlgorithmModel { get }
}

extension AlgorithmProtocol {
    
    var getPath: [String] {
        get {
            algorithm.path
        }
        set {
        }
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
    
    var getType: AlgorithmType {
        algorithm.type
    }
    
    var getSpeed: Double {
        get {
            algorithm.speed
        }
        set {
            algorithm.speed = newValue
        }
    }
}
