func breadthFirst(graph: [String: [String]], source: String, goal: String) -> [String] {
    var queue = [source]
    var visited = [String]()

    while !queue.isEmpty {
        let current = queue.removeFirst()
        if !visited.contains(current) {
            visited.append(current)
        }
        
        if(current == goal) {
            return visited
        }
        
        if let neighbors = graph[current] {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    queue.append(neighbor)
                }
            }
        }
    }
    
    return visited
}

