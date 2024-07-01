import Foundation

func breadthFirst(graph: [String: [String]], source: String, goal: String) -> SolutionPath {
    let queue = NSMutableOrderedSet(object: source)
    let visited = NSMutableOrderedSet()

    while queue.count > 0 {
        let current = queue.firstObject as! String
        queue.removeObject(at: 0)
        
        if !visited.contains(current) {
            visited.add(current)
        }
        
        if(current == goal) {
            return SinglePathSolution(visitedList: visited.array as! [String])
        }
        
        if let neighbors = graph[current] {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    queue.add(neighbor)
                }
            }
        }
    }
    
    return SinglePathSolution(visitedList: visited.array as! [String])
}


protocol SolutionPath {
    func nodes(for timeStamp: Int) -> [String]
    var maxSize: Int { get }
}

struct SinglePathSolution: SolutionPath {
    
    var visitedList: [String]
    
    var maxSize: Int {
        visitedList.count
    }
    
    func nodes(for timeStamp: Int) -> [String] {
        guard timeStamp < visitedList.count else { return [] }
        return [visitedList[timeStamp]]
    }
}
