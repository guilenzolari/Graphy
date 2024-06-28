func breadthFirst(graph: [String: [String]], source: String, goal: String) -> SolutionPath {
    var queue = [source]
    var visited = [String]()

    while !queue.isEmpty {
        let current = queue.removeFirst()
        if !visited.contains(current) {
            visited.append(current)
        }
        
        if(current == goal) {
            return SinglePathSolution(visitedList: visited)
        }
        
        if let neighbors = graph[current] {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    queue.append(neighbor)
                }
            }
        }
    }
    
    return SinglePathSolution(visitedList: visited)
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
