import Foundation

func depthFirst(graph: [String: [String]], source: String, goal: String) -> SolutionPath {
    var stack = [source]
    let visited = NSMutableOrderedSet()

    while !stack.isEmpty {
            let current = stack.removeLast()
        
        if !visited.contains(current) {
            visited.add(current)
        }
        
        if current == goal {
            return SinglePathSolution(
                    hasPath: true,
                    visitedList: visited.array as! [String],
                    finalPath: visited.array as! [String])
        }
        
        if let neighbors = graph[current] {
            for neighbor in neighbors.reversed() {
                if !visited.contains(neighbor) {
                    stack.append(neighbor)
                }
            }
        }
    }
    return SinglePathSolution(
        hasPath: false,
        visitedList: visited.array as! [String],
        finalPath: visited.array as! [String])
}
