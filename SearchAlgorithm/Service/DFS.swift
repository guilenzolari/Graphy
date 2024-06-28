func depthFirst(graph: [String: [String]], source: String, goal: String) -> SolutionPath {
    var stack = [source]
    var visited = [String]()

    while !stack.isEmpty {
        let current = stack.removeLast()
        if !visited.contains(current) {
            visited.append(current)
        }
        if(current == goal) {
            return SinglePathSolution(visitedList: visited)
        }
        
        if let neighbors = graph[current] {
            for neighbor in neighbors.reversed() {
                if !visited.contains(neighbor) {
                    stack.append(neighbor)
                }
            }
        }
    }
    
    return SinglePathSolution(visitedList: visited)
}
